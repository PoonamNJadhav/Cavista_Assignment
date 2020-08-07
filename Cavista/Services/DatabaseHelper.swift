//
//  DatabaseHelper.swift
//  Cavista
//
//  Created by Lawand, Poonam on 05/08/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//

import Foundation

class DataHelper {
        
    static let shareInstance = DataHelper()
    // Create a singleton thread safe
        private  init() {
            
    }
    
        
    func parseAndSaveData(jsonData:Data) -> [ContentViewModel]{
        var contentList = [ContentViewModel]()
         do {
        // Parse JSON data
           
            var contents = try JSONDecoder().decode([ContentModel].self, from: jsonData)
           
            contents = contents.sorted(by: { $0.type! > $1.type! })
            
       contentList += contents.map({return ContentViewModel($0)})
            DatabaseManager.sharedInstance.add(contents)
         }
         catch(let ex)
         {
            print(ex.localizedDescription)
         }
            return contentList
        
        }
    //Fetch Content offline
    func fetchFromDataBase() -> [ContentViewModel]?{
        var contents = [ContentViewModel]()
        //fetch data from database to support offline mode
        let contentList = DatabaseManager.sharedInstance.fetchDataFromDatabase()
        
        contents = contentList.map({return ContentViewModel($0)})
           return contents
        }
  
}
