//
//  User.swift
//  Beblue_TwitterAPI
//
//  Created by Fernando Cani on 6/7/16.
//  Copyright © 2016 com.fernandocani. All rights reserved.
//

import UIKit
import CoreData

@objc(UserCD)
class UserCD: NSManagedObject {
    
    @NSManaged var userID:      String?
    @NSManaged var userName:    String?
    
}
