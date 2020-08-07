//
//  NetworkManager.swift
//  Cavista
//
//  Created by Lawand, Poonam on 05/08/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//

import Foundation
import Alamofire

enum Result <T, E>{
    case success(T)
    case error(E)
}

protocol NetworkManagerProtocol {
    
    func fetchDataWith(_ url:URL,completion: @escaping (Result<Data?, Error?>) -> Void)
}

class NetworkManager: NSObject{
   
    static let shared = NetworkManager()
    let dataCache = NSCache<AnyObject, AnyObject>()
    // Create a singleton thread safe
    private override init() {
        
    }
    
}

extension NetworkManager: NetworkManagerProtocol {
   
    //fetch data from server using Alamofire SDK
    func fetchDataWith(_ url:URL,completion: @escaping (Result<Data?, Error?>) -> Void) {
     
        //Send Request to get data from server
        AF.request(url).response { (response) in
            if let err = response.error
            {
              completion(.error(err))
               return
             }
         //response parsing
                          
            guard let data = response.data else {
                  completion(.error(response.error))
                    return
                
            }
            completion(.success(data))
        }
       
    }
    
    //Use data cheche to store request records to use furture
   
    func fetchDataWithCache(_ url:URL,completion: @escaping (Result<Data?, Error?>) -> Void) {
        //check data is in cache
        if let data = self.dataCache.object(forKey: url as AnyObject) as? Data {
            completion(.success(data))
          
        } else {
            fetchDataWith(url,completion: {(result) in
            switch result {
                case .success(let data):
                    self.dataCache.setObject(data as AnyObject, forKey: url as AnyObject)
                    completion(.success(data))
                
                case .error(let error):
                    completion(.error(error))
                   
                }
            })
            
        }
    }
  
}
