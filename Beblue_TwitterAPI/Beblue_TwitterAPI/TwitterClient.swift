//
//  TwitterClient.swift
//  Beblue_TwitterAPI
//
//  Created by Fernando Cani on 6/7/16.
//  Copyright © 2016 com.fernandocani. All rights reserved.
//

import UIKit

let apiConsumerKey      = "CARwThpWh3ylHD3Jp6wqUHxrm"
let apiConsumerSecret   = "OrVhFMxSmbSEb4C6oyQpwNeHMKx5aszFUCfEb3V5CjbP8oXsCC"

let twitterConsumerKey = "4QHE4kyiC3c3T1U1KW4oc7PFt"
let twitterConsumerSecret = "BDsANeiRZjbi5FwKgh7FwQ56dGBIPKq4AFPXRRMMS3ZWyCcZx8"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (posts: [Posts]?, error: NSError?) -> ()) {
        self.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let statuses = Posts.statusesWithArray(response as! [NSDictionary])
            completion(posts: statuses, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                print("error getting home timeline")
                completion(posts: nil, error: error)
        })
    }
    
    func postStatusUpdateWithParams(params: NSDictionary?, completion: (posts: Posts?, error: NSError?) -> ()) {
        self.POST("1.1/statuses/update.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let status = Posts(dictionary: response as! NSDictionary)
            completion(posts: status, error: nil)
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            print("error posting status update")
            completion(posts: nil, error: error)
        }
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        self.loginCompletion = completion
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "bebluetwitter://oauth"), scope: nil, success: { (requestToken: BDBOAuthToken!) -> Void in
            print("Got the request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
        }) {
            (error: NSError!) -> Void in
            print("Failed to get request token")
            self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
        self.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: url.query), success: { (accessToken: BDBOAuthToken!) -> Void in
            print("Got the access token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    print("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })
        }) { (error: NSError!) -> Void in
            print("Failed to receive access token")
            self.loginCompletion?(user: nil, error: error)
        }
    }
    
}