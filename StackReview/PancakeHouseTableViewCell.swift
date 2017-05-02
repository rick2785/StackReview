//
//  PancakeHouseTableViewCell.swift
//  StackReview
//
//  Created by Rickey Hrabowskie on 5/1/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//

import UIKit

class PancakeHouseTableViewCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var pancakeImage : UIImageView!
  @IBOutlet weak var ratingImage: UIImageView!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var priceGuideLabel: UILabel!
  
  var pancakeHouse : PancakeHouse? {
    didSet {
      if let pancakeHouse = pancakeHouse {
        nameLabel?.text = pancakeHouse.name
        pancakeImage?.image = pancakeHouse.thumbnail ?? UIImage(named: "placeholder_thumb")
        ratingImage?.image = pancakeHouse.rating.smallRatingImage
        cityLabel?.text = pancakeHouse.city
        priceGuideLabel?.text = "\(pancakeHouse.priceGuide)"
      }
    }
  }
}
