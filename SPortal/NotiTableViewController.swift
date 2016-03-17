//
//  NotiTableViewController.swift
//  SPortal
//
//  Created by Tanakorn on 3/9/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit

class NotiTableViewController: UITableViewController {
    var noti = [Notification]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addNoti()
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return noti.count
    }
    func addNoti(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy/H/mm/ss"
        let someDate1 = "03/9/2016/13/45/04"
        let someDate2 = "03/8/2016/10/00/05"
        let someDate3 = "02/9/2016/18/01/30"

        let noti1 = Notification(image_profile:"jjamie",name:"JJamie Ratchata",date:someDate1,title:"Create an Event",checked:"false")
        let noti2 = Notification(image_profile:"kirk",name:"Kirk Lertritpuwadol",date:someDate2,title:"Join Starwar Running Event",checked:"false")
        let noti3 = Notification(image_profile:"profilePic",name:"Tanakorn Rattanajariya",date:someDate3,title:"Join an Event",checked:"true")
                noti += [noti1,noti2,noti3]
//        let urlPath: String = "http://localhost/Project/sportTable.json"
//            var url: NSURL = NSURL(string: urlPath)!
//            var request1: NSURLRequest = NSURLRequest(URL: url)
//            var response: AutoreleasingUnsafeMutablePointer<NSURLResponse? >= nil
//            var error: NSErrorPointer = nil
//            do{
//            var dataVal: NSData =  try NSURLConnection.sendSynchronousRequest(request1, returningResponse: response)
//            var jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
//            print("Synchronous \(jsonResult)")
//            var a = jsonResult.valueForKey("events")!
//            for i in 0...a.count-1 {
//                noti.append(Notification(image_profile: a[i].valueForKey("image_profile")! as! String, name: a[i].valueForKey("name")! as! String, date: a[i].valueForKey("date") as! String, title: a[i].valueForKey("title") as! String, checked: a[i].valueForKey("check") as! String))
//            }
//            }catch{
//            
//            }

    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        
        // Configure the cell...
        let image_profile = cell.viewWithTag(1) as! UIImageView
        image_profile.image = UIImage(named: noti[indexPath.row].image_profile)
        image_profile.layer.masksToBounds = false
        image_profile.layer.cornerRadius = 35
        image_profile.clipsToBounds = true
        let name = cell.viewWithTag(2) as! UILabel
        name.text = noti[indexPath.row].name
        let title = cell.viewWithTag(3) as! UILabel
        title.text = noti[indexPath.row].title
        let date = cell.viewWithTag(4) as! UILabel
        let today = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy/H/mm/ss"
        let someDate = dateFormatter.dateFromString(noti[indexPath.row].date)
        let interval = today.timeIntervalSinceDate(someDate!)
        let (hr,  minf) = modf (interval / 3600)
        let (min, secf) = modf (60 * minf)
        let (day, hrf) = modf(hr / 24)
        let (month,dayf) = modf(day / 30)
        let (year,monthf) = modf(month/12)
        if year >= 1{
            if(year == 1){
                date.text = String(Int(year))+" year ago"
            }else{
            date.text = String(Int(year))+" years ago"
            }
        }else {
            if month >= 1{
                if(month == 1){
                    date.text = String(Int(month))+" month ago"
                }else{
                date.text = String(Int(month))+" months ago"
                }
            }else{
                if day >= 2 {
                    date.text = String(Int(day))+" days ago"
                }else if (Int(day) <= 2 && Int(day) >= 1) {
                    date.text = "yesterday"
                }else{
                    if Int(hr) < 1 {
                        date.text = String(Int(min))+" minuits ago"
                    }else{
                        date.text = String(Int(hr))+" hours ago"
                    }
                }
            }
        }
        
        let bg = cell.viewWithTag(5) as UIView!
        if noti[indexPath.row].checked == "true" {
            bg.backgroundColor = UIColor.whiteColor()
        }
        return cell
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
