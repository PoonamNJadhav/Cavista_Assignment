//
//  Utilities.swift
//  Cavista
//
//  Created by Lawand, Poonam on 06/08/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//

import Foundation

class Utilities {
    
    //Function to change date formate to "DD MMM YYYY"
    //Return : "DD MMM YYYY" formatted date
    class func dateFormatConvertor(_ fromString:String)-> String {
      var date = Date()
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "mm/dd/yyyy"
      date = dateFormatter.date(from:fromString)!
      dateFormatter.dateFormat = "DD MMM YYYY"
      return dateFormatter.string(from: date)
  }
}
