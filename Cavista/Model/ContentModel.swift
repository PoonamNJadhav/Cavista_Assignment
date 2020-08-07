//
//  ContentModel.swift
//  Cavista
//
//  Created by Lawand, Poonam on 05/08/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//


import RealmSwift

class ContentModel: Object,Decodable {
    
   @objc dynamic var id :String = ""
   @objc dynamic var type : String?
   @objc dynamic var date : String?
   @objc dynamic var data : String?
     
    
    override static func primaryKey() -> String? {
        return "id"
    }
        enum CodingKeys: String, CodingKey {
    
            case id = "id"
            case type = "type"
            case date = "date"
            case data = "data"
        }

        //Mark : Decodable
        required convenience init(from decoder: Decoder) throws {
            self.init()
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
            self.type = try values.decodeIfPresent(String.self, forKey: .type)
            self.date = try values.decodeIfPresent(String.self, forKey: .date)
            self.data = try values.decodeIfPresent(String.self, forKey: .data)
            
    }
}
