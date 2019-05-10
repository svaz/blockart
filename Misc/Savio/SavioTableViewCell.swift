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

//  override func awakeFromNib() {
//        super.awakeFromNib()
//        print("Initialization code")
//    
//    }
////
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        print(" setSelected the view for the selected state")
//    }

  func configure( cellViewModel: SavioPhoto?) {
   // if let _ = cellViewModel.albumId?.stringValue{
      self.albumId!.text = cellViewModel?.albumId?.stringValue
      self.title!.text = cellViewModel?.title
      self.id.text = cellViewModel?.id?.stringValue
     if let url = cellViewModel?.thumbnailUrl {
      self.imageViewSmall!.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
    }
  }
}
