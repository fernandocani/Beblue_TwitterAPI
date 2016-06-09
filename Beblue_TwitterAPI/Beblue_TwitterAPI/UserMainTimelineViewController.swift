//
//  UserMainTimelineViewController.swift
//  Beblue_TwitterAPI
//
//  Created by Fernando Cani on 6/7/16.
//  Copyright © 2016 com.fernandocani. All rights reserved.
//

import UIKit

class UserMainTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!

    var posts: [Posts]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NSNotificationCenter.defaultCenter().addObserverForName(TwitterEvents.StatusPosted, object: nil, queue: nil) { (notification: NSNotification) -> Void in
//            let status = notification.object as! Status
//            self.statuses?.insert(status, atIndex: 0)
//            self.tableView.reloadData()
//        }
        
        loadPosts()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.tableView.addPullToRefreshWithActionHandler {
            TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (posts, error) -> () in
                self.loadPosts()
            })
//        }
    }
    
    func loadPosts() {
//        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (posts, error) -> () in
//            if self.tableView.pullToRefreshView != nil {
//                self.tableView.pullToRefreshView.stopAnimating()
//            }
            self.posts = posts
            self.tableView.reloadData()
            
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                MBProgressHUD.hideHUDForView(self.view, animated: true)
//                return ()
            })
//        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("postsCell") as! PostsTableViewCell
        cell.posts = self.posts?[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
//        let controller = storyboard.instantiateViewControllerWithIdentifier("PostsView") as! PostsViewController
//        controller.posts = self.posts![indexPath.row]
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts?.count ?? 0
    }
    
}

class PostsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var postsTextLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var posts: Posts? {
        willSet(newValue) {
            self.profileImage.setImageWithURL(newValue?.user.profileImageUrl)
            self.nameLabel.text = newValue?.user.name
            self.screennameLabel.text = "@\(newValue!.user.screenname)"
            self.postsTextLabel.text = newValue?.text
            self.timeLabel.text = newValue?.createdAt.timeAgo()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.profileImage.layer.cornerRadius = 9.0
        self.profileImage.layer.masksToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        
    }
    
}