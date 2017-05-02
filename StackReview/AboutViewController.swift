//
//  AboutViewController.swift
//  StackReview
//
//  Created by Rickey Hrabowskie on 5/1/17.
//  Copyright © 2017 Rickey Hrabowskie. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
  
  
  @IBOutlet weak var contentStackView: UIStackView!
  fileprivate var copyrightStackView: UIStackView?
  
  @IBOutlet weak var backgroundImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
}


extension AboutViewController {
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    let image = imageForAspectRatio(size.width / size.height)
    
    coordinator.animate(alongsideTransition: {
      context in
      // Create a transition and match the context's duration
      let transition = CATransition()
      transition.duration = context.transitionDuration
      
      // Make it fade
      transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      transition.type = kCATransitionFade
      self.backgroundImageView.layer.add(transition, forKey: "Fade")
      
      // Set the new image
      self.backgroundImageView.image = image
      }, completion: nil)
  }
  
  
  fileprivate func configureView() {
    let aspectRatio = view.bounds.size.width / view.bounds.size.height
    self.backgroundImageView.image = imageForAspectRatio(aspectRatio)
  }
  
  fileprivate func imageForAspectRatio(_ aspectRatio : CGFloat) -> UIImage? {
    return UIImage(named: aspectRatio > 1 ? "pancake3" : "placeholder")
  }
}



extension AboutViewController {
  @IBAction func handleCopyrightButtonTapped(_ sender: AnyObject) {
    if copyrightStackView != .none {
      UIView.animate(withDuration: 0.8, animations: {
        self.copyrightStackView?.isHidden = true
        }, completion: { _ in
          self.copyrightStackView?.removeFromSuperview()
          self.copyrightStackView = .none
      })
    } else {
      copyrightStackView = createCopyrightStackView()
      copyrightStackView?.isHidden = true
      contentStackView.addArrangedSubview(copyrightStackView!)
      UIView.animate(withDuration: 0.8, animations: {
        self.copyrightStackView?.isHidden = false
      }) 
    }
  }
  
  fileprivate func createCopyrightStackView() -> UIStackView? {
    let imageView = UIImageView(image: UIImage(named: "rw_logo"))
    imageView.contentMode = .scaleAspectFit
    
    let label = UILabel()
    label.text = "(c) Razeware 2015"
    
    let stackView = UIStackView(arrangedSubviews: [imageView, label])
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fillEqually
    
    return stackView
  }

}


