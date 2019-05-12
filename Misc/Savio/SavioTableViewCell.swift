//
//  SavioTableViewCell.swift
//  SavioVaz
//
//  Created by savio vaz on 4/23/19.
//  Copyright © 2019 savio vaz. All rights reserved.
//

import UIKit
import SDWebImage

class SavioTableViewCell: UITableViewCell {
  var cellViewModel: SavioPhoto?

  @IBOutlet weak var imageViewSmall: UIImageView!
  @IBOutlet weak var id: UILabel!
  @IBOutlet weak var albumId: UILabel!
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var price: UILabel!
  @IBOutlet weak var creationDate: UILabel!
  @IBOutlet weak var descriptions: UILabel!
  @IBOutlet weak var artist: UILabel!
  
  func configure( cellViewModel: SavioPhoto?) {
   // if let _ = cellViewModel.albumId?.stringValue{
     // self.albumId!.text = cellViewModel?.albumId?.stringValue
      self.title!.text = cellViewModel?.title
     if let price = cellViewModel?.price {
      self.price.text = price + " ETH"
    }
    self.artist.text = cellViewModel?.artist
    self.descriptions.text = cellViewModel?.description
    //  self.id.text = cellViewModel?.id?.stringValue
    
    if let imageFile = cellViewModel?.imageFile {
      self.imageViewSmall.image = UIImage(named: imageFile)
    }
    
     if let url = cellViewModel?.thumbnailUrl {
      self.imageViewSmall!.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
    }
  }
}
