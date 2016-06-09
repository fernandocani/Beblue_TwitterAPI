//
//  UserSingleton.swift
//  Beblue_TwitterAPI
//
//  Created by Fernando Cani on 6/7/16.
//  Copyright © 2016 com.fernandocani. All rights reserved.
//

import UIKit
import CoreLocation

class UserSingleton: NSObject {
    
    // MARK: - Singleton
    class var sharedInstance: UserSingleton {
        struct Static {
            static let instance: UserSingleton = UserSingleton()
        }
        return Static.instance
    }
    
    var userID = String()
    var userName = String()
    
}