//
//  UserCreateTableViewController.swift
//  SPortal
//
//  Created by Tanakorn on 2/8/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit

class UserCreateTableViewController: UITableViewController {
    @IBOutlet weak var max: UILabel!
    
    var price :Int!
    
    var latitude : Double!
    var longitude :Double!
    @IBOutlet var players: UISlider!
    @IBOutlet weak var finishTimeText: UILabel!
    @IBOutlet weak var finishTime: UIDatePicker!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var dates: UIDatePicker!
    @IBOutlet weak var times: UIDatePicker!
    @IBOutlet weak var SportTT: UILabel!
    @IBOutlet weak var LocationTitle: UILabel!
    @IBAction func playerSlider(sender: UISlider) {
        var current = Double(sender.value)*10
        let y = Int(round(current)/1)
        max.text = "\(y)"
    }
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    var fromSegue :String = "Select Place"
    var selectedCellIndexPath: NSIndexPath?
    let selectedCellHeight: CGFloat = 200.0
    let unselectedCellHeight: CGFloat = 44.0
    var sportType : String = "Select Type"
    @IBAction func clickConfirm(sender: UIButton) {
        check()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var a = NSBundle.mainBundle().objectForInfoDictionaryKey("storeData")!
        var dateFormatter = NSDateFormatter()
        let today = NSDate()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        var strDate = dateFormatter.stringFromDate(today)
        Date.text = strDate
        Time.text = "10:00 AM"
        finishTimeText.text = "11:00 AM"
        max.text = "Select max players"
        //var finish = Int(strTime)
        //finish = finish!+1
        LocationTitle.text = fromSegue
        dates.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        times.addTarget(self, action: Selector("timePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        finishTime.addTarget(self, action: Selector("finishTimePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        SportTT.text = sportType
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func calculatePrice(max:Int,place:String,type:String) ->Int{
        var price :Int = 0
        if place == "CU SportComplex" {
            switch type{
            case "Football" : price = 1200
            case "Workout" : price = 2500
            case "Yoga" : price = 500
            case "Boxing" : price = 500
            default:price = 0
            }
            if type == "Football" {
                price = price/max
            }
        }
        return price
    }
    func datePickerChanged(datePicker:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        print(strDate)
        Date.text = strDate
    }
    func timePickerChanged(datePicker:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        Time.text = strDate
        
    }
    func finishTimePickerChanged(datePicker:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        finishTimeText.text = strDate
        
    }
    func check(){
        if self.LocationTitle.text == "Didn't Selected" || self.max.text == "Select max players" {
            let alertController = UIAlertController(title: "Error", message:
                "You didn't completed the event", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }else{
            self.price = calculatePrice(Int(max.text!)!, place : LocationTitle.text!, type: SportTT.text!)
            createEvent()
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
        return 6
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if selectedCellIndexPath == indexPath {
            if indexPath.row == 1 || indexPath.row == 0 || indexPath.row == 6 {
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
    func createEvent(){
        let postEndPoint: String = "http://requestb.in/t4puk4t4"
        let url = NSURL(string: postEndPoint)!
        let session = NSURLSession.sharedSession()
        let str = ["e_id":"1","u_id":"1","type":self.SportTT.text!,"e_date":Date.text!,"time":Time.text!,"f_time":finishTimeText.text!,"place":LocationTitle.text!,"price":String(price),"latitude":String(latitude),"longitude":String(longitude),"attend":"1","max":max.text!]
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        do{
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(str, options: NSJSONWritingOptions())
            print(str)
        }catch{
            print("error cant post")
        }
        session.dataTaskWithRequest(request,completionHandler: {
            (data:NSData?,response:NSURLResponse?,error: NSError?) -> Void in
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else{
                    print("not 200")
                    return
            }
            if let postString = NSString(data:data!,encoding:  NSUTF8StringEncoding) as? String {
                print("POST:"+postString)
            }
        }).resume()
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
