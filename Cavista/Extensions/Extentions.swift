//
//  Extentions.swift
//  Cavista
//
//  Created by Lawand, Poonam on 07/08/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//

import UIKit

let dataCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
   
   //Download image data async and set to imageView
  func downloadAsyncImage(_ imageURL:URL) {
      
        //Configure activity indicator
          let activityView = UIActivityIndicatorView()
          activityView.center = super.center
          super.addSubview(activityView)
          activityView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self.snp.center)
           }
         activityView.startAnimating()
        
          DispatchQueue.global().async { [weak self] in
                 
                 if let imageFromCache = dataCache.object(forKey: imageURL as AnyObject) as? UIImage {
                     DispatchQueue.main.async {
                         self?.image = imageFromCache
                         activityView.stopAnimating()
                         activityView.removeFromSuperview()
                     }
                     return
                 }
                 
                 if let data = try? Data(contentsOf: imageURL) {
                     if let image = UIImage(data: data) {
                         DispatchQueue.main.async {
                             self?.image = image
                             dataCache.setObject(image, forKey: imageURL as AnyObject)
                             activityView.stopAnimating()
                             activityView.removeFromSuperview()
                         }
                     }
                 } else {
                     DispatchQueue.main.async {
                         activityView.stopAnimating()
                         activityView.removeFromSuperview()
                     }
                     
                 }
             }
         
      }
  }
  //extenting UIViewController by adding show alert method to show UIAlertController on UIViewController

extension UIViewController {

  func showAlert(withTitle title: String, message : String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//    let OKAction = UIAlertAction(title:"OK", style: .default) { action in
//    }
//    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}
