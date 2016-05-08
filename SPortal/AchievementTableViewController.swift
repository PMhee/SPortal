//
//  AchievementTableViewController.swift
//  SPortal
//
//  Created by JJamie Rashata on 3/4/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit

class AchievementTableViewController: UITableViewController {
    
    
    struct Acheivement{
        var image: UIImage?
        var title: String
        var date: String
    }
    var urlPath:String!
    var userID : String!
    var user = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.urlPath = "http://localhost:3000/getProfile/"+self.userID
        getProfile()
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
        return self.user[0].achievement.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("achievementCell", forIndexPath: indexPath)
        // Configure the cell...
        let image_achievement = cell.viewWithTag(1) as! UIImageView
        if self.user[0].achievement[indexPath.row].valueForKey("checked")! as! NSObject == 0{
            image_achievement.image = UIImage(named: "achievement_black")
        }else {
            image_achievement.image = UIImage(named: "achievement")
        }
        print((self.user[0].achievement[indexPath.row].valueForKey("title")! as! String))
        let title = cell.viewWithTag(2) as! UILabel
        title.text = self.user[0].achievement[indexPath.row].valueForKey("title")! as! String
         if self.user[0].achievement[indexPath.row].valueForKey("checked")! as! NSObject == 0{
        let date = cell.viewWithTag(3) as! UILabel
        date.text = (self.user[0].achievement[indexPath.row].valueForKey("date")! as! String).substringWithRange(Range<String.Index>(start: (self.user[0].achievement[indexPath.row].valueForKey("date")! as! String).startIndex.advancedBy(0), end: (self.user[0].achievement[indexPath.row].valueForKey("date")! as! String).startIndex.advancedBy(10)))
            date.hidden = true
         }else{
            let date = cell.viewWithTag(3) as! UILabel
            date.text = (self.user[0].achievement[indexPath.row].valueForKey("date")! as! String).substringWithRange(Range<String.Index>(start: (self.user[0].achievement[indexPath.row].valueForKey("date")! as! String).startIndex.advancedBy(0), end: (self.user[0].achievement[indexPath.row].valueForKey("date")! as! String).startIndex.advancedBy(10)))
            
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

    
    func loadSampleAchievement(){
        let acheivement1 = Acheivement(image: UIImage(named: "achievement.png"),title: "Man of the match",date: "Fri, March 7")
        let acheivement2 = Acheivement(image: UIImage(named: "achievement.png"),title: "Join Sportal 10 times",date: "Fri, March 6")
        let acheivement3 = Acheivement(image: UIImage(named: "achievement.png"),title: "Target achieved",date: "Fri, March 5")
        let acheivement4 = Acheivement(image: UIImage(named: "achievement_black.png"),title: "Best pace",date: "")
        let acheivement5 = Acheivement(image: UIImage(named: "achievement_black.png"),title: "Superstar of Sportal",date: "")
        let acheivement6 = Acheivement(image: UIImage(named: "achievement_black.png"),title: "Longest distance",date: "")
        let acheivement7 = Acheivement(image: UIImage(named: "achievement_black.png"),title: "You will never walk alone",date: "")
        
        
        //acheivements += [acheivement1,acheivement2,acheivement3,acheivement4,acheivement5,acheivement6,acheivement7]
        //let urlPath: String = "http://localhost/Project/sportTable.json"
//        var url: NSURL = NSURL(string: urlPath)!
//        var request1: NSURLRequest = NSURLRequest(URL: url)
//        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse? >= nil
//        var error: NSErrorPointer = nil
//        do{
//            var dataVal: NSData =  try NSURLConnection.sendSynchronousRequest(request1, returningResponse: response)
//            var jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
//            print("Synchronous \(jsonResult)")
//            var a = jsonResult.valueForKey("events")!
//            for i in 0...a.count-1 {
//                acheivements.append(Acheivement(image: UIImage(named: a[i].valueForKey("image")! as! String), title: a[i].valueForKey("title")! as! String, date: a[i].valueForKey("date")! as! String))
//            }
//        }catch{
//            
//        }
        
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
