//
//  LoginViewController.swift
//  Beblue_TwitterAPI
//
//  Created by Fernando Cani on 6/7/16.
//  Copyright © 2016 com.fernandocani. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        if DataStore.sharedInstance.hasUser() {
////            let user = DataStore.sharedInstance.getUser()
////            UserSingleton.sharedInstance.userID     = user.userID!
////            UserSingleton.sharedInstance.userName   = user.userName!
////            self.performSegueWithIdentifier("toMain", sender: self)
//        } else {
////            let logInButton = TWTRLogInButton { (session, error) in
////                if let unwrappedSession = session {
////                    print(unwrappedSession)
////                    if DataStore.sharedInstance.createUser(UserID: unwrappedSession.userID, UserName: unwrappedSession.userName) {
////                        let user = DataStore.sharedInstance.getUser()
////                        UserSingleton.sharedInstance.userID     = user.userID!
////                        UserSingleton.sharedInstance.userName   = user.userName!
////                        self.performSegueWithIdentifier("toMain", sender: self)
////                    }
////                } else {
////                    NSLog("Login error: %@", error!.localizedDescription);
////                }
////            }
////            // TODO: Change where the log in button is positioned in your view
////            logInButton.center.x = self.view.center.x
////            logInButton.center.y = self.view.frame.height - 30
////            self.view.addSubview(logInButton)
//        }
    }
    
    @IBAction func login(sender: UIButton) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                self.performSegueWithIdentifier("toMain", sender: self)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    // Logout
    // Swift
    let store = Twitter.sharedInstance().sessionStore
     
    if let userID = store.session?.userID {
        store.logOutUserID(userID)
    }
    */
    
}