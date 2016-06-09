//
//  PostsViewController.swift
//  Beblue_TwitterAPI
//
//  Created by Fernando Cani on 6/9/16.
//  Copyright © 2016 com.fernandocani. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet weak var profileImage:        UIImageView!
    @IBOutlet weak var nameLabel:           UILabel!
    @IBOutlet weak var screennameLabel:     UILabel!
    @IBOutlet weak var postsTextLabel:      UILabel!
    @IBOutlet weak var dateLabel:           UILabel!
    @IBOutlet weak var retweetNumberLabel:  UILabel!
    @IBOutlet weak var favoriteNumberLabel: UILabel!
    
    var posts: Posts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Tweet"
        
        self.profileImage.setImageWithURL(self.posts?.user.profileImageUrl)
        self.profileImage.layer.cornerRadius = 9.0
        self.profileImage.layer.masksToBounds = true
        self.nameLabel.text = self.posts?.user.name
        self.screennameLabel.text = "@\(self.posts!.user.screenname)"
        self.postsTextLabel.text = self.posts?.text
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy 'at' h:mm aaa"
        self.dateLabel.text = formatter.stringFromDate(self.posts!.createdAt)
        
        self.retweetNumberLabel.text = "\(self.posts!.retweets)"
        self.favoriteNumberLabel.text = "\(self.posts!.favorites)"
    }
    
}