//
//  ContentDetailViewController.swift
//  Cavista
//
//  Created by Lawand, Poonam on 06/08/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire


class ContentDetailViewController: UIViewController {
    
    var contentObject: ContentViewModel?
    fileprivate var idLabel:UILabel?
    fileprivate var imageView: UIImageView?
    fileprivate var textView:UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        prepareSubViews()
       
     }
    //update table constarints
   override func viewWillLayoutSubviews() {
    idLabel?.textAlignment = .center
    idLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
         idLabel!.snp.makeConstraints {
                 $0.left.equalToSuperview().offset(10)
                 $0.right.equalToSuperview().offset(-10)
                 $0.top.equalToSuperview().offset(100)
                 $0.height.equalTo(30)
            }
    
  }
    
  
    
  /// Function to setup Detail View Controller
     func prepareSubViews() {
         view.backgroundColor = .white
        guard let currentObj = contentObject else {
            return
        }
        idLabel = UILabel()
        idLabel?.text = currentObj.contentTitle
        view.addSubview(idLabel!)
        
        if(contentObject?.contentType != "image"){
                   imageView = nil
                   textView = UITextView()
                   textView?.text = contentObject?.contentData
                   textView?.font = UIFont.systemFont(ofSize: 18)
                   view.addSubview(textView!)
                   addConstraints(textView!,afterView: idLabel!)
                   
               }
               else {
            if let imageURLPath = URL(string:contentObject?.contentlink ?? "") {
                    imageView = UIImageView()
                    imageView?.image =  UIImage(named: "defaultImageView")
                    textView = nil
                    view.addSubview(imageView!)
                    
                    addConstraints(imageView!,afterView: idLabel!)
                    imageView?.downloadAsyncImage(imageURLPath)
                    
                    
            }
                 
               }
       
     }
    func addConstraints(_ view: UIView,afterView : UIView) {
        view.snp.makeConstraints {
             $0.left.equalToSuperview().offset(10)
             $0.right.equalToSuperview().offset(-10)
             $0.top.equalTo(afterView.snp.bottom).offset(20)
             $0.height.equalTo(200)
        }
        
    }
}
 
