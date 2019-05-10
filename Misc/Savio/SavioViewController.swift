//
//  SavioViewController.swift
//   

//  Created by savio vaz on 4/24/19.
//  Copyright © 2019 savio vaz. All rights reserved.
//

import UIKit
import SDWebImage

class SavioViewController: UIViewController, SavioModelDataSourceDelegate {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  var delegate: SavioModelDataSourceDelegate?
  lazy var viewModel: SavioModelViewDataSource = {
    return SavioModelViewDataSource()
  }()

  var selectedCellData: SavioPhoto?

  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
  }


  // MARK: Redirection to Detail view
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destVC : DetailViewController = segue.destination as! DetailViewController
    destVC.photoItem = self.selectedCellData
  }
}

extension SavioViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.photoSectionCount
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.photosCount
  }

  private func viewModelForCell(at index: Int) -> SavioPhoto? {
    if let cellIndex = viewModel.allPhotos?[index] {
       return SavioPhoto(savioPhoto: cellIndex)
    }
    return nil
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
    self.selectedCellData = viewModel.allPhotos?[indexPath.row]
    performSegue(withIdentifier: "detailSegue", sender: self)
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


extension SavioViewController {  
  
  // MARK: Delegate calls
  func loadData() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  func postError(message: String) {
    print(message)
  }
  
  private func initView() {
    self.tableView.register(UINib (nibName: "SavioTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    self.viewModel.delegate = self
    self.viewModel.getData(retrievedType: .photos)
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.activityIndicator.hidesWhenStopped = true
    self.viewModel.updateLoadingStatusClosure = { [weak self] () in
      DispatchQueue.main.async {
        let isLoading = self?.viewModel.isLoading ?? false
        if isLoading {
          self?.activityIndicator.startAnimating()
          UIView.animate(withDuration: 0.2, animations: {
            self?.tableView.alpha = 0.0
          })}else {
          self?.activityIndicator.stopAnimating()
          UIView.animate(withDuration: 0.2, animations: {
            self?.tableView.alpha = 1.0
          })
        }
      }
    }
  }

}
