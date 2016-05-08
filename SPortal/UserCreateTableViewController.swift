//
//  UserCreateTableViewController.swift
//  SPortal
//
//  Created by Tanakorn on 2/8/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKLoginKit
import FBSDKCoreKit
class UserCreateTableViewController: UITableViewController,UITextFieldDelegate {
    @IBOutlet var createTitle: UILabel!
    @IBOutlet var putTitle: UITextField!
    @IBAction func changeTitle(sender: UITextField) {
        createTitle.text = sender.text
    }
    @IBOutlet weak var max: UILabel!
    var price :Int!
    var latitude : Double!
    var longitude :Double!
    var sendDay : String!
    var sendMonth : String!
    var sendYear : String!
    var sendStartHour : String!
    var sendStartMin : String!
    var sendFinHour : String!
    var sendFinMin : String!
    var sendDate : String!
    @IBOutlet var players: UISlider!
    @IBOutlet weak var finishTimeText: UILabel!
    @IBOutlet weak var finishTime: UIDatePicker!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var dates: UIDatePicker!
    @IBOutlet weak var times: UIDatePicker!
    @IBOutlet weak var SportTT: UILabel!
    @IBOutlet weak var LocationTitle: UILabel!
    var userName : String!
    var firstName : String!
    var key :String!
    var user_id :String!
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
    var sportType : String!
    @IBAction func clickConfirm(sender: UIButton) {
        check()
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
                print("fetched user: \(result)")
                self.user_id = result.valueForKey("id")! as! String
                self.userName = result.valueForKey("name") as! String
                self.firstName = result.valueForKey("first_name") as! String
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        returnUserData()
        self.putTitle.delegate = self
        Alamofire.request(.GET, "http://localhost:3000/requestCsrf")
            .responseString { response in
                print("Response String: \(response.result.value)")
                self.key = String(response.result.value!)
                print(self.key)
        }
        var a = NSBundle.mainBundle().objectForInfoDictionaryKey("storeData")!
        var dateFormatter = NSDateFormatter()
        let today = NSDate()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        var strDate = dateFormatter.stringFromDate(today)
        Date.text = strDate
        self.sendDate = strDate
        Time.text = "10:00 AM"
        self.sendStartHour = "10:00"
        finishTimeText.text = "11:00 AM"
        self.sendFinHour = "11:00"
        max.text = "Select max players"
        self.putTitle.delegate = self
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
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.characters.count - range.length
        return newLength <= 24
    }
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        userText.resignFirstResponder()
        return true;
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
        var sendFormatter = NSDateFormatter()
        sendFormatter.dateFormat = "yyyy-MM-dd"
        self.sendDate = sendFormatter.stringFromDate(datePicker.date)
        print(self.sendDate)
        print(strDate)
        Date.text = strDate
//        let text = self.sendDate
//        var count = 0;
//        var range: Range<String.Index> = text.rangeOfString("/")!
//        var index: Int = text.startIndex.distanceTo(range.startIndex)
//        for i in 0...index-1{
//            let index = text.startIndex.advancedBy(i)
//            print(text[index])
//            count++
//        }
//        text.substringWithRange(Range<String.Index>(start: text.startIndex.advancedBy(index+1), end: text.endIndex.advancedBy(0)))
//        range = text.substringWithRange(Range<String.Index>(start: text.startIndex.advancedBy(index+1), end: text.endIndex.advancedBy(0))).rangeOfString("/")!
//        var r = text.startIndex.distanceTo(range.startIndex)
//        index++
//        for i in index...index+r-1{
//            let index = text.startIndex.advancedBy(i)
//            print(text[index])
//            count++
//        }
//        count+=2
//        print(text.substringWithRange(Range<String.Index>(start: text.startIndex.advancedBy(count), end: text.endIndex.advancedBy(0))))
    }
    func timePickerChanged(datePicker:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        Time.text = strDate
        print(strDate)
        var sendFormatter = NSDateFormatter()
        sendFormatter.dateFormat = "HH:mm:ss"
        self.sendStartHour = sendFormatter.stringFromDate(datePicker.date)
        print(self.sendStartHour)

    }
    func finishTimePickerChanged(datePicker:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        finishTimeText.text = strDate
        print(strDate)
        var sendFormatter = NSDateFormatter()
        sendFormatter.dateFormat = "HH:mm:ss"
        self.sendFinHour = sendFormatter.stringFromDate(datePicker.date)
        print(self.sendFinHour)

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
        return 7
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if selectedCellIndexPath == indexPath {
            if indexPath.row == 1 || indexPath.row == 0 || indexPath.row == 7 {
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
        NSNotificationCenter.defaultCenter().postNotificationName("sendNotificationID", object: nil)
        let icon = self.SportTT.text!+" icon"
        let bg = self.SportTT.text!+" bg"
        self.sendFinHour = self.sendDate+" "+self.sendFinHour+".000Z"
        let joinPerson : NSDictionary = ["user_id":self.user_id]
        let eventID = self.user_id
        let description:String = createTitle.text!
        let parameters = [
            "message": ["type":self.SportTT.text!,"startTime":self.sendDate+" "+self.sendStartHour+".000Z","finishTime":self.sendFinHour,"place":LocationTitle.text!,"latitude":String(latitude),"longitude":String(longitude),"maxPerson":max.text!,"createdId":eventID,"description":description,"author":self.userName,"price":self.price,"image":icon,"bg":bg,"pic":self.firstName,"joinPerson":joinPerson],"_csrf":self.key
        ]
        Alamofire.request(.POST, "http://localhost:3000/addEvent", parameters: parameters as! [String : AnyObject], encoding: .JSON)
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