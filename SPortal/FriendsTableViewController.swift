//
//  FriendsTableViewController.swift
//  SPortal
//
//  Created by Tanakorn on 3/6/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    struct Friend {
        var image_profile: UIImage?
        var name: String
    }
    
    var friends = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleFriend()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }
    
    func loadSampleFriend(){
        let friend1 = Friend(image_profile: UIImage(named: "jjamie.jpg"),name: "JJamie Rashata")
        let friend2 = Friend(image_profile: UIImage(named: "profilePic.jpg"),name: "Tanakorn Ratanajariya")
        let friend3 = Friend(image_profile: UIImage(named: "kirk.jpg"),name: "Kirk Lertritpuwadol")
        let friend4 = Friend(image_profile: UIImage(named: "best.jpg"),name: "Kittinun Kaewtae")
        let friend5 = Friend(image_profile: UIImage(named: "off.jpg"),name: "Chanthawat Rattanapongphan")
        
        friends += [friend1,friend2,friend3,friend4,friend5]
        
    }


    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        
        // Configure the cell...
        let friend = friends[indexPath.row]
        
        let image_profile = cell.viewWithTag(1) as! UIImageView
        image_profile.image = friend.image_profile
        image_profile.layer.masksToBounds = false
        image_profile.layer.cornerRadius = 20
        image_profile.clipsToBounds = true
        
        
        let name = cell.viewWithTag(2) as! UILabel
        name.text = friend.name
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
