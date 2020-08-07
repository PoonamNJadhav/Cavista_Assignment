//
//  ClientService.swift
//  Cavista
//
//  Created by Lawand, Poonam on 05/08/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//

import Foundation
import UIKit

class ClientService : NSObject{
    
    static let shared = ClientService() //Singleton class object
   
     // Create a singleton thread safe
        private override init() {
            
    }
    //Fetch data from server ,not caching data
    func fetchData(completion:@escaping (Result<Data?, Error?>) -> Void) {
        let urlString = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"
        guard let url = URL(string: urlString) else { return }
        NetworkManager.shared.fetchDataWith(url, completion:completion)
    }
    
 
    

}
