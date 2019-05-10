//
//  MyArtViewController.swift
//  BlockArt
//
//  Created by savio vaz on 5/10/19.
//  Copyright © 2019 savio vaz. All rights reserved.
//


import Foundation
import UIKit
import RMessage

class MyArtViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  //  var delegate: SavioModelDataSourceDelegate?
  lazy var viewModel: SavioModelViewDataSource = {
    return SavioModelViewDataSource()
  }()
  let refreshControl = UIRefreshControl()
  var selectedCellData: SavioPhoto?
  var sections: [Any] = []
  
  //For without Protocols
  var apiService: APIServiceStore = APIServiceStore()
  var allPhotos: [SavioPhoto] = []{
    didSet {
      self.getSections()
      self.tableView.reloadData()
      self.refreshControl.endRefreshing()
    }
  }
  var customSpecMessage = DefaultRMessageSpec()
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.initView()
    fetchArtData()
  }
  
  
  // MARK: Delegate calls
  //  func loadData() {
  //    DispatchQueue.main.async {
  //      self.tableView.reloadData()
  //    }
  //  }
  //  func postError(message: String) {
  //    print(message)
  //  }
  // MARK: Redirection to Detail view
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destVC : DetailSellViewController = segue.destination as! DetailSellViewController
    destVC.photoItem = self.selectedCellData
  }
}

extension MyArtViewController{
  
  @objc func refresh() {
    // Code to refresh table view
    fetchArtData()
  }
  
  private func getSections() {
    // TO BE USED IF SECTIONS ARE REQUIRED
    let sortedAlbums = Array( Set(allPhotos.map({$0.albumId }))).compactMap { $0 }.sorted()
    for iteration in sortedAlbums {
      let albumID = iteration
      let filtered = allPhotos.filter { $0.albumId == albumID }
      sections.append([albumID: filtered])
    }
  }
  
  private func fetchArtData() {
    self.allPhotos = []
    self.activityIndicator.startAnimating()
    
    self.apiService.fetchArtData(from: endPointURL,successHandler: {[unowned self] (response) in
      self.allPhotos = response
      
      RMController().showMessage(withSpec: self.customSpecMessage,title :"Success pulling in \(self.allPhotos.count) items")
      self.activityIndicator.stopAnimating()
      print(response.count)
    }) { [unowned self] (error) in
      self.activityIndicator.stopAnimating()
      print(error.localizedDescription)
      RMController().showMessage(withSpec: self.customSpecMessage,title: error.localizedDescription)
    }
  }
  
   private func initView() {
    self.title = " My Art"
    self.tableView.register(UINib (nibName: "SavioTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    //    self.viewModel.delegate = self
    //    self.viewModel.getData(retrievedType: .Photos)
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.activityIndicator.hidesWhenStopped = true
    self.customSpecMessage.backgroundColor = .red
    self.customSpecMessage.titleColor = .white
    self.customSpecMessage.bodyColor = .white
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    tableView.addSubview(refreshControl)
    
    self.viewModel.updateLoadingStatusClosure = { [weak self] () in
      DispatchQueue.main.async {
        let isLoading = self?.viewModel.isLoading ?? false
        if isLoading {
          self?.activityIndicator.startAnimating()
          UIView.animate(withDuration: 0.2, animations: {
            self?.tableView.alpha = 0.0
          }) } else {
          self?.activityIndicator.stopAnimating()
          UIView.animate(withDuration: 0.2, animations: {
            self?.tableView.alpha = 1.0
          })
        }
      }
    }
  }
  
  
}
extension MyArtViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allPhotos.count
  }
  private func viewModelForCell(at index: Int) -> SavioPhoto? {
    return SavioPhoto(savioPhoto: allPhotos[index])
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SavioTableViewCell else {
      debugPrint("Cell not exists in storyboard")
      return UITableViewCell()
    }
    cell.configure(cellViewModel: viewModelForCell(at: indexPath.row))
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.selectedCellData =  allPhotos[indexPath.row]
    performSegue(withIdentifier: "myArtDetailSegue", sender: self)
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return UITableView.automaticDimension
    } else {
      return 140
    }
  }
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return UITableView.automaticDimension
    } else {
      return 140
    }
  }
}
