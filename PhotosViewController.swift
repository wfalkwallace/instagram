//
//  PhotosViewController.swift
//  instagram
//
//  Created by Aditya Jayaraman on 2/4/15.
//  Copyright (c) 2015 copdepath. All rights reserved.
//

import UIKit

class PhotosViewController: UITableViewController {

    var photos = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 500

        // Do any additional setup after loading the view.
        
        var clientId = "bdb5bb241ee04feda789792264ddf9d7"
        
        var url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(clientId)")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            self.photos = responseDictionary["data"] as NSArray
            self.tableView.reloadData()
            
            //println("response: \(self.photos)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.photocell") as PhotosTableViewCell
        
        cell.usernameLabel.text = (self.photos[indexPath.row]["user"] as NSDictionary)["username"] as String
        let imageURL = ((self.photos[indexPath.row]["images"] as NSDictionary)["standard_resolution"] as NSDictionary)["url"] as NSString
        
        let url = NSURL(string: imageURL)
        
        //var placeholder = UIImage(named : "AppIcon")
        cell.instagramImageView.setImageWithURL(url)
        return cell
    }


}
