//
//  FriendsTableViewController.swift
//  SPortal
//
//  Created by Tanakorn on 3/6/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKLoginKit
import FBSDKCoreKit
class showSportPlayerTableViewController: UITableViewController {
    
    var friends = [Friend]()
    var joined : NSArray!
    var userID : String!
    var user_id : String!
    var user = [User]()
    var urlPath :String!
    var eventID :String!
    var key : String!
    var author : Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(.GET, "http://localhost:3000/requestCsrf")
            .responseString { response in
                print("Response String: \(response.result.value)")
                self.key = String(response.result.value!)
                print(self.key)
        }
        //loadFriend()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func returnUserData(){
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, gender, age_range "])
        
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched users: \(result)")
                self.user_id = result.valueForKey("id")! as! String
            }
        })
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.user = [User]()
        returnUserData()
        for i in 0...joined.count-1{
        self.urlPath = "http://localhost:3000/getProfile/"+(self.joined[i].valueForKey("user_id") as! String)
        getProfile()
        
        }
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.user.count
    }
    
    func getProfile(){
        var url: NSURL = NSURL(string: urlPath)!
        var request1: NSURLRequest = NSURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse? >= nil
        var error: NSErrorPointer = nil
        do{
            var dataVal: NSData =  try NSURLConnection.sendSynchronousRequest(request1, returningResponse: response)
            var jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            print("Synchronous \(jsonResult)")
            var firstName:String = jsonResult.valueForKey("displayName")! as! String
            var range: Range<String.Index> = firstName.rangeOfString(" ")!
            var index: Int = firstName.startIndex.distanceTo(range.startIndex)
            //                print(jsonResult.valueForKey("facebookId")! as! String)
            //                print(jsonResult.valueForKey("displayName")! as! String)
            //                print(firstName.substringWithRange(Range<String.Index>(start: firstName.startIndex.advancedBy(0), end: firstName.startIndex.advancedBy(index))))
            //                print(jsonResult.valueForKey("achievement")! as! NSArray)
            //                print(jsonResult.valueForKey("notification")! as! NSArray)
            //                print(jsonResult.valueForKey("friends")! as! NSArray)
            //                print(jsonResult.valueForKey("favorite")! as! NSArray)
            let data :User = User(UserID:jsonResult.valueForKey("facebookId") as? String,Username:jsonResult.valueForKey("displayName") as? String,profilePic:firstName.substringWithRange(Range<String.Index>(start: firstName.startIndex.advancedBy(0), end: firstName.startIndex.advancedBy(index))),achievement:jsonResult.valueForKey("achievement") as? NSArray,notification:jsonResult.valueForKey("notification") as? NSArray,friends:jsonResult.valueForKey("friends") as? NSArray,favourite:jsonResult.valueForKey("favorite") as? NSArray,About:jsonResult.valueForKey("about") as! String,newNotification:jsonResult.valueForKey("newNotification") as? NSArray,receipt:jsonResult.valueForKey("receipt") as? NSArray,stat:jsonResult.valueForKey("stat") as? NSArray,newFeed:jsonResult.valueForKey("newFeed") as? NSArray)
            self.user.append(data)
        }catch{
            
        }
        var err: NSError
        print(response)
        
    }
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if self.author == true{
            if(indexPath.row>0){
                return UITableViewCellEditingStyle.Delete
                
            }else{
                UITableViewCellEditingStyle.None
            }
        }else{
            return UITableViewCellEditingStyle.None
        }
        return UITableViewCellEditingStyle.None
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // Delete the row from the data source
            let parameters = ["message":["eventId":self.eventID,"user_id":self.joined[indexPath.row].valueForKey("user_id") as! String],"_csrf":self.key
            ]
            Alamofire.request(.POST, "http://localhost:3000/removePlayer", parameters:parameters as? [String : AnyObject], encoding: .JSON)
            self.user.removeAtIndex(indexPath.row)
            //print(self.user.count)
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.tableView.reloadData()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }

    }
override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyle.None
    let image_profile = cell.viewWithTag(1) as! UIImageView
    print(indexPath.row)
    image_profile.image = UIImage(named:self.user[indexPath.row].profilePic)
    image_profile.layer.masksToBounds = false
    image_profile.layer.cornerRadius = 20
    image_profile.clipsToBounds = true
    let name = cell.viewWithTag(2) as! UILabel
    name.text = self.user[indexPath.row].Username
//    let remove = cell.viewWithTag(3) as! UIButton
//    if indexPath.row == 0 {
//        remove.hidden = true
//    }
    let label = cell.viewWithTag(3) as! UILabel
    if(indexPath.row == 0){
        label.hidden = true
    }
        if self.author == false {
            label.hidden = true
        }else{
            if indexPath.row == 0 {
                label.hidden = true
            }else{
            label.hidden = false
            }
    }
    return cell
}
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let des = segue.destinationViewController as? OtherViewController{
            var indexPath = self.tableView.indexPathForSelectedRow!
            des.userID = self.joined[indexPath.row].valueForKey("user_id") as! String
        }
    }
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
