//
//  Posts.swift
//  Beblue_TwitterAPI
//
//  Created by Fernando Cani on 6/8/16.
//  Copyright © 2016 com.fernandocani. All rights reserved.
//

import UIKit

class Posts: NSObject {
    
    var user:       User
    var text:       String
    var createdAt:  NSDate
    var retweets:   Int
    var favorites:  Int
    
    init(dictionary: NSDictionary) {
        self.user = User(dictionary: dictionary["user"] as! NSDictionary)
        self.text = dictionary["text"] as! String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        self.createdAt = formatter.dateFromString(dictionary["created_at"] as! String)!
        
        self.retweets = dictionary["retweet_count"] as! Int
        self.favorites = dictionary["favorite_count"] as! Int
    }
    
    class func statusesWithArray(array: [NSDictionary]) -> [Posts] {
        var posts = [Posts]()
        for dictionary in array {
            posts.append(Posts(dictionary: dictionary))
        }
        return posts
    }
}
