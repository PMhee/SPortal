//
//  UserCreateTableViewController.swift
//  SPortal
//
//  Created by Tanakorn on 2/8/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit

class UserCreateTableViewController: UITableViewController {
    
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var dates: UIDatePicker!
    @IBAction func price(sender: UISlider) {
        var current = Double(sender.value)*2000
        let y = Double(round(current)/1)
        Price.text = "\(y)"
    }
    @IBOutlet weak var times: UIDatePicker!
    @IBOutlet weak var SportTT: UILabel!
    @IBOutlet weak var LocationTitle: UILabel!
    var fromSegue :String = "Select Place"
    var selectedCellIndexPath: NSIndexPath?
    let selectedCellHeight: CGFloat = 200.0
    let unselectedCellHeight: CGFloat = 44.0
    var sportType : String = "Select Type"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var a = NSBundle.mainBundle().objectForInfoDictionaryKey("storeData")!
        
        LocationTitle.text = fromSegue
        dates.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        times.addTarget(self, action: Selector("timePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        SportTT.text = sportType
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func datePickerChanged(datePicker:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        Date.text = strDate
    }
    func timePickerChanged(datePicker:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        Time.text = strDate
        
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
        return 5
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if selectedCellIndexPath == indexPath {
            if indexPath.row == 1 || indexPath.row == 0 {
            return unselectedCellHeight
            }else
            {
                return selectedCellHeight
            }
        }
        return unselectedCellHeight
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if selectedCellIndexPath != nil && selectedCellIndexPath == indexPath {
            selectedCellIndexPath = nil
        } else {
            selectedCellIndexPath = indexPath
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        if selectedCellIndexPath != nil {
            // This ensures, that the cell is fully visible once expanded
            tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
        }
    }
    //1
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
