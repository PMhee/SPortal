//
//  SelectTableViewController.swift
//  SPortal
//
//  Created by Tanakorn on 2/24/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit

class SelectTableViewController: UITableViewController {
    
    var place :String = ""
    struct Sport{
        var type: String!
        var icon : String!
        var bg : String!
    }
    var sport = [Sport]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSport()
//        var Aframe = [UIView]()
//        var Abg = [UIImageView]()
//        Aframe.append(frame)
//        Aframe.append(frame1)
//        Aframe.append(frame2)
//        Aframe.append(frame3)
//        Abg += [bg1,bg2,bg3,bg4]
//        for i in 0...3 {
//            //            Abg[i].image = Abg[i].image!.applyBlurWithRadius(3, tintColor: UIColor(white: 0.5, alpha: 0.4), saturationDeltaFactor: 1.8)
//            Aframe[i].layer.masksToBounds = false
//            Aframe[i].layer.cornerRadius = 35
//            Aframe[i].clipsToBounds = true
//        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func addSport(){
        var sport1 = Sport(type:"Football",icon:"Football icon",bg:"Football bg")
        var sport2 = Sport(type:"Boxing",icon:"Boxing icon",bg:"Boxing bg")
        var sport3 = Sport(type:"Yoga",icon:"Yoga icon",bg:"Yoga bg")
        var sport4 = Sport(type:"Workout",icon:"Workout icon",bg:"Workout bg")
        var sport5 = Sport(type:"Basketball",icon:"Basketball icon",bg:"Basketball bg")
        var sport6 = Sport(type:"Badminton",icon:"Badminton icon",bg:"Badminton bg")
        var sport7 = Sport(type:"Tennis",icon:"Tennis icon",bg:"Tennis bg")
        var sport8 = Sport(type:"BBGun",icon:"BBGun icon",bg:"BBGun bg")
        var sport9 = Sport(type:"Baseball",icon:"Baseball icon",bg:"Baseball bg")
        self.sport += [sport1,sport8,sport9,sport5,sport2,sport7,sport3,sport4,sport6]
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.selectionStyle = UITableViewCellSelectionStyle.Default
        let bg = cell.viewWithTag(1) as! UIImageView
        bg.image = UIImage(named: self.sport[indexPath.row].bg)
        let icon = cell.viewWithTag(4) as! UIImageView
        icon.image = UIImage(named: self.sport[indexPath.row].icon)
        let views = cell.viewWithTag(2) as UIView!
        views.layer.masksToBounds = false
        views.layer.cornerRadius = 35
        views.clipsToBounds = true
        let type = cell.viewWithTag(3) as! UILabel
        type.text = self.sport[indexPath.row].type
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let des = segue.destinationViewController as? UserMakeAppointmentViewController{
            var indexPath = self.tableView.indexPathForSelectedRow!
            des.sportType = self.sport[indexPath.row].type
            print(self.sport[indexPath.row].type)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.sport.count
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
