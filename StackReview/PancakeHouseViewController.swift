//
//  PancakeHouseViewController.swift
//  StackReview
//
//  Created by Rickey Hrabowskie on 5/1/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//

import UIKit
import MapKit

class PancakeHouseViewController : UIViewController {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var detailsLabel: UILabel!
  @IBOutlet weak var priceGuideLabel: UILabel!
  @IBOutlet weak var ratingImage: UIImageView!
  @IBOutlet weak var showDetailsButton: UIButton!
  @IBOutlet weak var showMapButton: UIButton!


  var pancakeHouse : PancakeHouse? {
    didSet {
      configureView()
    }
  }
  
  func configureView() {
    // Update the user interface for the detail item.
    if let pancakeHouse = pancakeHouse {
      nameLabel?.text = pancakeHouse.name
      imageView?.image = pancakeHouse.photo ?? UIImage(named: "placeholder")
      detailsLabel?.text = pancakeHouse.details
      priceGuideLabel?.text = "\(pancakeHouse.priceGuide)"
      ratingImage?.image = pancakeHouse.rating.ratingImage
      centreMap(mapView, atPosition: pancakeHouse.location)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }
}

extension PancakeHouseViewController {
  fileprivate func centreMap(_ map: MKMapView?, atPosition position: CLLocationCoordinate2D?) {
    guard let map = map,
      let position = position else {
        return
    }
    map.isZoomEnabled = false
    map.isScrollEnabled = false
    map.isPitchEnabled = false
    map.isRotateEnabled = false
    
    map.setCenter(position, animated: true)
    
    let zoomRegion = MKCoordinateRegionMakeWithDistance(position, 10000, 10000)
    map.setRegion(zoomRegion, animated: true)
    
    let annotation = MKPointAnnotation()
    annotation.coordinate = position
    map.addAnnotation(annotation)
  }
}

extension PancakeHouseViewController {
  fileprivate func animateView(_ view: UIView, toVisible visible: Bool) {
    UIView.animate(withDuration: 0.8,
      delay: 0,
      usingSpringWithDamping: 0.8,
      initialSpringVelocity: 10,
      options: UIViewAnimationOptions(),
      animations: {
        view.isHidden = !visible
      },
      completion: .none)
  }
  
  @IBAction func handleShowHideDetailsTapped(_ sender: AnyObject) {
    let buttonTitle = detailsLabel.isHidden ? "Hide Details" : "Show Details"
    showDetailsButton.setTitle(buttonTitle, for: UIControlState())
    animateView(detailsLabel, toVisible: detailsLabel.isHidden)
  }
  
}
