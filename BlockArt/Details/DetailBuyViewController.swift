//
//  DetailBuyViewController.swift
//  BlockArt
//
//  Created by savio vaz on 5/10/19.
//  Copyright © 2019 savio vaz. All rights reserved.
//

import UIKit

class DetailBuyViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var imageTitle: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  @IBOutlet weak var artist: UILabel!
  @IBOutlet weak var buyButton: UIButton!

  @IBOutlet weak var price: UITextField!
  @IBOutlet weak var creationDate: UILabel!
  public var photoItem: SavioPhoto?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
  }
  
  private func  initView() {
    guard let _ = photoItem else {
      print("ERROR ************* NO PHOTOITEM")
      return
    }
    
    self.artist.text = photoItem?.artist
    if let price = photoItem?.price {
    self.price.text = price + " ETH"
    }
     self.creationDate.text = photoItem?.creationDate
    
    self.imageTitle.text = photoItem?.title
    if let imageFile = photoItem?.imageFile {
      self.imageView.image = UIImage(named: imageFile)
    }

  }
  @IBAction func buyAction() {
    print("buy")
    if let navController = self.navigationController {
      navController.popViewController(animated: true)
    }
  }

}
