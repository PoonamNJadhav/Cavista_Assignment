//
//  DatabaseManager.swift
//  Cavista
//
//  Created by Lawand, Poonam on 05/08/20.
//  Copyright © 2020 Lawand, Poonam. All rights reserved.
//


import RealmSwift

class DatabaseManager {
    
    private var database:Realm
    static let sharedInstance = DatabaseManager()
    
    private init() {
     database = try! Realm()
    }
    
    //To fetch data/recoreds from database
    func fetchDataFromDatabase() -> Results<ContentModel> {
        let results: Results<ContentModel> = database.objects(ContentModel.self).sorted(byKeyPath: "type", ascending: true)
        return results
    }
    
    //To add record/object in database
    func add(_ object: ContentModel) {
        
        try! database.write {
            database.add(object, update: Realm.UpdatePolicy.all)
            print("Added new object")
        }
    }
    //To add list of object in database
    func add(_ objects: [ContentModel]) {
        
        try! database.write {
            database.add(objects, update: Realm.UpdatePolicy.modified)
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            print("Added new object List")
        }
    }
      //To delete all records from database
    func deleteAllDatabase()  {
        try! database.write {
            database.deleteAll()
        }
    }
    
    //To delete perticular object/record from database
    func deleteFromDb(object: ContentModel) {
        try! database.write {
            database.delete(object)
        }
    }
    
}
