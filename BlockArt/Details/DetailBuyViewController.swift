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
  
  @IBOutlet weak var buyButton: UIButton!

  public var photoItem: SavioPhoto?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
  }
  
  private func  initView() {
    self.imageTitle.text = photoItem?.title
    if let url = photoItem?.url {
      self.imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
    }
  }
  @IBAction func buyAction() {
    print("buy")
  }

}