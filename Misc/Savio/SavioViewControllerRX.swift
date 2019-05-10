//
//  SavioViewControllerRX.swift
//  SavioVaz
//
//  Created by savio vaz on 4/30/19.
//  Copyright © 2019 savio vaz. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RMessage

struct Place: Decodable {
  let name: String
  let desc: String
  let url: String
}

class SavioViewControllerRX: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var activityIndicator: UIActivityIndicatorView!
   let refreshControl = UIRefreshControl()
  
  let places: BehaviorRelay<[Place]> = BehaviorRelay(value: [])
  let disposeBag = DisposeBag()
  var allPhotos: BehaviorRelay<[SavioPhoto]> = BehaviorRelay(value: [])
   var apiService: APIServiceStore = APIServiceStore()
  var customSpecMessage = DefaultRMessageSpec()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.initView()
    
    self.allPhotos.bind(to: tableView.rx.items(cellIdentifier: "cellRx", cellType: SavioTableViewCell.self)) { (row, model, cell) in
        cell.configure(cellViewModel: model)
      }
      .disposed(by: disposeBag)
    
    tableView.rx
      .modelSelected(String.self)
      .subscribe(onNext:  { value in
        print("Tapped \(value)" )
      })
      .disposed(by: disposeBag)
    
    tableView.rx
      .itemAccessoryButtonTapped
      .subscribe(onNext: { indexPath in
         print("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
      })
      .disposed(by: disposeBag)
    
    fetchDataPhotos()
    
  }

  
}



extension SavioViewControllerRX {
  private func fetchDataPhotos() {
  
    self.apiService.fetchArtData(from: endPointURL,successHandler: {[unowned self] (response) in
      self.allPhotos.accept(response)
      
      RMController().showMessage(withSpec: self.customSpecMessage,title :"Success pulling in --?? items")
      self.activityIndicator.stopAnimating()
      self.refreshControl.endRefreshing()
      print(response.count)
    }) { [unowned self] (error) in
      self.activityIndicator.stopAnimating()
      self.refreshControl.endRefreshing()
      print(error.localizedDescription)
      RMController().showMessage(withSpec: self.customSpecMessage,title: error.localizedDescription)
    }
  }
  
  @objc func refresh() {
    // Code to refresh table view
    fetchDataPhotos()
  }
 
  private func initView() {
    self.tableView.delegate = nil
    self.tableView.dataSource = nil
    self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    self.activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    self.activityIndicator.center = self.tableView.center
    self.activityIndicator.startAnimating()
    self.tableView.addSubview(self.activityIndicator)
    self.activityIndicator.hidesWhenStopped = true
     self.tableView.addSubview(refreshControl)
    self.tableView.tableFooterView = UIView() //Prevent empty rows
//    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellRx")
    self.tableView.register(UINib (nibName: "SavioTableViewCell", bundle: nil), forCellReuseIdentifier: "cellRx")
    
  }
  



}


//class TableViewCellRx: UITableViewCell {
//
//  @IBOutlet weak var labelFullName: UILabel!
//
//
//
//   func bindCell(fullName: String) {
//    labelFullName?.text =  fullName
//
//  }
//}
