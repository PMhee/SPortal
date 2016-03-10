//
//  SelectTableViewController.swift
//  SPortal
//
//  Created by Tanakorn on 2/24/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit

class SelectTableViewController: UITableViewController {

    @IBOutlet weak var bg1: UIImageView!
    @IBOutlet weak var bg2: UIImageView!
    @IBOutlet weak var bg3: UIImageView!
    @IBOutlet weak var bg4: UIImageView!
    @IBOutlet weak var frame: UIView!
    @IBOutlet weak var frame1: UIView!
    @IBOutlet weak var frame2: UIView!
    @IBOutlet weak var frame3: UIView!
    var place :String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        var Aframe = [UIView]()
        var Abg = [UIImageView]()
        Aframe.append(frame)
        Aframe.append(frame1)
        Aframe.append(frame2)
        Aframe.append(frame3)
        Abg += [bg1,bg2,bg3,bg4]
        for i in 0...3 {
//            Abg[i].image = Abg[i].image!.applyBlurWithRadius(3, tintColor: UIColor(white: 0.5, alpha: 0.4), saturationDeltaFactor: 1.8)
            Aframe[i].layer.masksToBounds = false
            Aframe[i].layer.cornerRadius = 35
            Aframe[i].clipsToBounds = true
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let des = segue.destinationViewController as? UserMakeAppointmentViewController{
            if let identifier = segue.identifier{
                print("inn")
            switch identifier {
            case "Football" : des.sportType = "Football"
            case "BodyBuilding" : des.sportType = "BodyBuilding"
            case "Yoga" : des.sportType = "Yoga"
            case "Boxing" : des.sportType = "Boxing"
            default : des.sportType = ""
            }
            }
        }
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
        return 4
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
