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
    
    var acheivements = [Acheivement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleAchievement()
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
        return acheivements.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("achievementCell", forIndexPath: indexPath)
        
        // Configure the cell...
        let achievement = acheivements[indexPath.row]
        
        let image_achievement = cell.viewWithTag(1) as! UIImageView
        image_achievement.image = achievement.image
        let title = cell.viewWithTag(2) as! UILabel
        title.text = achievement.title
        let date = cell.viewWithTag(3) as! UILabel
        date.text = achievement.date
        
        return cell
    }
    
    
    
    func loadSampleAchievement(){
        let acheivement1 = Acheivement(image: UIImage(named: "achievement.png"),title: "Man of the match",date: "Fri, March 7")
         let acheivement2 = Acheivement(image: UIImage(named: "achievement.png"),title: "Join Sportal 10 times",date: "Fri, March 6")
         let acheivement3 = Acheivement(image: UIImage(named: "achievement.png"),title: "Target achieved",date: "Fri, March 5")
         let acheivement4 = Acheivement(image: UIImage(named: "achievement_black.png"),title: "Best pace",date: "")
         let acheivement5 = Acheivement(image: UIImage(named: "achievement_black.png"),title: "Superstar of Sportal",date: "")
         let acheivement6 = Acheivement(image: UIImage(named: "achievement_black.png"),title: "Longest distance",date: "")
         let acheivement7 = Acheivement(image: UIImage(named: "achievement_black.png"),title: "You will never walk alone",date: "")
        
        
        acheivements += [acheivement1,acheivement2,acheivement3,acheivement4,acheivement5,acheivement6,acheivement7]
        
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
