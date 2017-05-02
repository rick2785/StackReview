//
//  PancakeHouse.swift
//  StackReview
//
//  Created by Rickey Hrabowskie on 5/1/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//

import UIKit
import CoreLocation

enum PriceGuide : Int {
  case unknown = 0
  case low = 1
  case medium = 2
  case high = 3
}

extension PriceGuide : CustomStringConvertible {
  var description : String {
    switch self {
    case .unknown:
      return "?"
    case .low:
      return "$"
    case .medium:
      return "$$"
    case .high:
      return "$$$"
    }
  }
}

enum PancakeRating {
  case unknown
  case rating(Int)
}

extension PancakeRating {
  init?(value: Int) {
    if value > 0 && value <= 5 {
      self = .rating(value)
    } else {
      self = .unknown
    }
  }
}

extension PancakeRating {
  var ratingImage : UIImage? {
    guard let baseName = ratingImageName else {
      return nil
    }
    return UIImage(named: baseName)
  }
  
  var smallRatingImage : UIImage? {
    guard let baseName = ratingImageName else {
      return nil
    }
    return UIImage(named: "\(baseName)_small")
  }
  
  fileprivate var ratingImageName : String? {
    switch self {
    case .unknown:
      return nil
    case .rating(let value):
      return "pancake_rate_\(value)"
    }
  }
}



struct PancakeHouse {
  let name: String
  let photo: UIImage?
  let thumbnail: UIImage?
  let priceGuide: PriceGuide
  let location: CLLocationCoordinate2D?
  let details: String
  let rating: PancakeRating
  let city: String
}

extension PancakeHouse {
   init?(dict: [String : AnyObject]) {
    guard let name = dict["name"] as? String,
      let priceGuideRaw = dict["priceGuide"] as? Int,
      let priceGuide = PriceGuide(rawValue: priceGuideRaw),
      let details = dict["details"] as? String,
      let ratingRaw = dict["rating"] as? Int,
      let rating = PancakeRating(value: ratingRaw),
      let city = dict["city"] as? String else {
        return nil
    }

    self.name = name
    self.priceGuide = priceGuide
    self.details = details
    self.rating = rating
    self.city = city
    
    if let imageName = dict["imageName"] as? String, !imageName.isEmpty {
      photo = UIImage(named: imageName)
    } else {
      photo = nil
    }
    
    if let thumbnailName = dict["thumbnailName"] as? String, !thumbnailName.isEmpty {
      thumbnail = UIImage(named: thumbnailName)
    } else {
      thumbnail = nil
    }
    
    if let latitude = dict["latitude"] as? Double,
      let longitude = dict["longitude"] as? Double {
        location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    } else {
      location = nil
    }
  }
}

extension PancakeHouse {
  static func loadDefaultPancakeHouses() -> [PancakeHouse]? {
    return self.loadPancakeHousesFromPlistNamed("pancake_houses")
  }
  
  static func loadPancakeHousesFromPlistNamed(_ plistName: String) -> [PancakeHouse]? {
    guard let path = Bundle.main.path(forResource: plistName, ofType: "plist"),
      let array = NSArray(contentsOfFile: path) as? [[String : AnyObject]] else {
        return nil
    }
    
    return array.map { PancakeHouse(dict: $0) }
                .filter { $0 != nil }
                .map { $0! }
  }
}

extension PancakeHouse : CustomStringConvertible {
  var description : String {
    return "\(name) :: \(details)"
  }
}



