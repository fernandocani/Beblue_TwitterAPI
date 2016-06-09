//
//  DataStore.swift
//  Beblue_TwitterAPI
//
//  Created by Fernando Cani on 6/7/16.
//  Copyright © 2016 com.fernandocani. All rights reserved.
//

import UIKit
import CoreData

class DataStore {
    let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    // MARK: - Singleton
    class var sharedInstance: DataStore {
        struct Static {
            static let instance: DataStore = DataStore()
        }
        return Static.instance
    }
    
    // MARK: - User
    
    func createUser(
        UserID userID: String,
        UserName userName: String
        ) -> Bool {
        
        let userEntity = NSEntityDescription.entityForName("UserCD", inManagedObjectContext: managedContext)
        let user = UserCD(entity: userEntity!, insertIntoManagedObjectContext: managedContext)
        user.userID     = userID
        user.userName   = userName
        (try! managedContext.save())
        return true
    }
    
    func getUser() -> UserCD {
        let request = NSFetchRequest(entityName: "UserCD")
        let objects: [AnyObject]?
        objects = (try! managedContext.executeFetchRequest(request))
        return (objects!.first as! UserCD)
    }
    
    func hasUser() -> Bool {
        let request = NSFetchRequest(entityName: "UserCD")
        let objects: [AnyObject]?
        objects = (try! managedContext.executeFetchRequest(request))
        if objects!.count > 0 {
            return true
        }
        return false
    }
}