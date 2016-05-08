//
//  ReceiptTableViewController.swift
//  SPortal
//
//  Created by Tanakorn on 4/4/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
class ReceiptTableViewController: UITableViewController {
    var user = [User]()
    var urlPath : String!
    var size : Int!
    var receipt:Receipt!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.returnUserData()
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.size
    }
    override  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        //        if let imageView = cell.viewWithTag(1) as? UIImageView{
        //        imageView.image = UIImage(named: searchResult[indexPath.row].bg)!.applyBlurWithRadius(3, tintColor: UIColor(white: 0.5, alpha: 0.4), saturationDeltaFactor: 1.8)
        //        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        if self.user.count > 0{
        let name = cell.viewWithTag(1) as! UILabel
        name.text = self.user[0].receipt[indexPath.row].valueForKey("name") as! String
        let date = cell.viewWithTag(2) as! UILabel
        date.text = (self.user[0].receipt[indexPath.row].valueForKey("date") as! String).substringWithRange(Range<String.Index>(start: (self.user[0].receipt[indexPath.row].valueForKey("date") as! String).startIndex.advancedBy(0), end: (self.user[0].receipt[indexPath.row].valueForKey("date") as! String).endIndex.advancedBy(-14))) + " "+(self.user[0].receipt[indexPath.row].valueForKey("date") as! String).substringWithRange(Range<String.Index>(start: (self.user[0].receipt[indexPath.row].valueForKey("date") as! String).startIndex.advancedBy(11), end: (self.user[0].receipt[indexPath.row].valueForKey("date") as! String).endIndex.advancedBy(-8)))
        let price = cell.viewWithTag(3) as! UILabel
        price.text = String(self.user[0].receipt[indexPath.row].valueForKey("price") as! Int) + " THB"
        //        let back :UIView = UIView(frame: cell.frame)
        //        back.backgroundColor = UIColor(colorLiteralRed:171, green: 171, blue: 171, alpha: 1)
        //        cell.selectedBackgroundView = back
            
        }
        return cell
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
                let user_id = result.valueForKey("id")! as! String
                self.urlPath = "http://localhost:3000/getProfile/"+user_id
                self.getProfile()
                self.tableView.reloadData()
            }
        })
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let des = segue.destinationViewController as? showReceiptViewController{
            var indexPath = self.tableView.indexPathForSelectedRow!
            self.receipt = Receipt(date:self.user[0].receipt[indexPath.row].valueForKey("date") as! String,name:self.user[0].receipt[indexPath.row].valueForKey("name") as! String,price:self.user[0].receipt[indexPath.row].valueForKey("price") as! Int,place:self.user[0].receipt[indexPath.row].valueForKey("place") as! String,type:self.user[0].receipt[indexPath.row].valueForKey("event") as! String)
                des.user = self.receipt
    }
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
