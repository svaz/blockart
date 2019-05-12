//
//  DetailSellViewController.swift
//  BlockArt
//
//  Created by savio vaz on 5/10/19.
//  Copyright © 2019 savio vaz. All rights reserved.
//


import UIKit
import SDWebImage

class DetailSellViewController: UIViewController {

 
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
  @IBOutlet weak var sellButton: UIButton!
  
  public var photoItem: SavioPhoto?
    
    override func viewDidLoad() {
      super.viewDidLoad()
      initView()
    }
    
    private func  initView() {
      self.imageTitle.text = photoItem?.title
//      self.artist.text = photoItem?.artist
//      self.price.text = photoItem?.price
//      self.creationDate.text = photoItem?.creationDate
      
      self.imageTitle.text = photoItem?.title
      if let imageFile = photoItem?.imageFile {
        self.imageView.image = UIImage(named: imageFile)
      }
    }
  @IBAction func sellAction() {
    print("Sell")
    if let navController = self.navigationController {
      navController.popViewController(animated: true)
    }
  }
}

extension DetailSellViewController {
  
  
}
