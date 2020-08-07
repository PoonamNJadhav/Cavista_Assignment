//
//  ContentViewModel.swift
//  Cavista
//
//  Created by Lawand, Poonam on 05/08/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//

import Foundation
 

class ContentViewModel {
    
    let contentTitle: String
    let contentType:String?
    let contentDate:String?
    let contentData:String?
    let contentlink:String?
    
    // Dependency Injection
       init(_ content: ContentModel) {
        self.contentTitle =  String(content.id) 
        self.contentType =  content.type
        self.contentDate = content.date != nil && content.date != "" ? Utilities.dateFormatConvertor(content.date!) : ""
       
        contentData = (content.type != "image") ? content.data : nil
        contentlink = (content.type == "image") ? content.data : nil
        
    }
   
  
   
}

