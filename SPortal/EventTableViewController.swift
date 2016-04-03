//
//  TrainerTableViewController.swift
//  SPortal
//
//  Created by Tanakorn on 1/25/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import FBSDKLoginKit
import FBSDKCoreKit
class EventTableViewController: UITableViewController,UISearchBarDelegate {
    let imageArray = ["fitness icon","yoga icon","boxing icon","fitness icon","fitness icon","football icon"]
    var searchResult = [DataToPass]()
    var selectedCellIndexPath: NSIndexPath?
    @IBOutlet var searchBar: UISearchBar!
    var events = [DataToPass]()
    var user_id : String!
    var user = [User]()
    var searchActive : Bool = false
    @IBOutlet weak var myTable: UITableView!
    @IBAction func DismissKeyboard(sender: AnyObject) {
        self.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        let notificationSettings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Badge , categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
    }
    func dismissS(sender:UITapGestureRecognizer){
        self.searchBar.resignFirstResponder()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        returnUserData()
        addEvents()
        self.tableView.reloadData()
    }
    func refresh(refreshControl: UIRefreshControl) {
        // Do your job, when done:
        addEvents()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
        searchBar.resignFirstResponder()
        addEvents()
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        searchBar.resignFirstResponder()
        addEvents()
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        searchBar.resignFirstResponder()
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchActive{
            self.search(searchText)
            self.tableView.reloadData()
        }
    }
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id "])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
            }
            else
            {
                self.user_id = result.valueForKey("id") as! String
                self.getProfile()
                let tabArray = self.tabBarController?.tabBar.items as NSArray!
                let tabItem = tabArray.objectAtIndex(3) as! UITabBarItem
                if(self.user[0].newNotification.count == 0){
                    tabItem.badgeValue = nil
                }else{
                tabItem.badgeValue = String(self.user[0].newNotification.count)
                }
                var noti = ["user_id":self.user_id]
            }
        })
    }
    func getProfile(){
        self.user = [User]()
        let urlPath: String = "http://localhost:3000/getProfile/"+self.user_id
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
            let data :User = User(UserID:jsonResult.valueForKey("facebookId")! as! String,Username:jsonResult.valueForKey("displayName")! as! String,profilePic:firstName.substringWithRange(Range<String.Index>(start: firstName.startIndex.advancedBy(0), end: firstName.startIndex.advancedBy(index))),achievement:jsonResult.valueForKey("achievement")! as! NSArray,notification:jsonResult.valueForKey("notification")! as! NSArray,friends:jsonResult.valueForKey("friends")! as! NSArray,favourite:jsonResult.valueForKey("favorite")! as! NSArray,About:jsonResult.valueForKey("about") as! String,newNotification:jsonResult.valueForKey("newNotification") as! NSArray)
            print(data)
            self.user.append(data)
        }catch{
            
        }
        var err: NSError
        print(response)
        
    }
    func addEvents(){
        //        let event1 = DataToPass(type:"Boxing",date:"March 12, 2016",time:"10:40",f_time:"11:40",place:"Chulalongkorn University",author:"Tanakorn Rattanajariya",price:"500",latitude: "13.73888",longitude: "100.52586",bg: "boxing bg",attendant: "1",max:"5",pic:"profilePic")
        //        let event2 = DataToPass(type:"Football",date:"March 13, 2016",time:"12:00",f_time:"14:00",place:"Chulalongkorn University",author:"JJamie Ratchata",price:"120",latitude: "13.73888",longitude: "100.52586",bg: "football bg",attendant: "7",max:"10",pic:"jjamie")
        //        let event3 = DataToPass(type:"Workout",date:"March 14, 2016",time:"11:30",f_time:"12:40",place:"Chulalongkorn University",author:"Chantawat Rattana",price:"700",latitude: "13.73888",longitude: "100.52586",bg: "workout bg",attendant: "5",max:"5",pic:"off")
        //        let event4 = DataToPass(type:"yoga",date:"March 15, 2016",time:"10:30",f_time:"11:40",place:"Chulalongkorn University",author:"Kittinun Kaewtae",price:"300",latitude: "13.73888",longitude: "100.52586",bg: "yoga bg",attendant: "3",max:"5",pic:"best")
        //        events += [event1,event2,event3,event4]
        //        searchResult = events
        //    Alamofire.request(.GET, "http://localhost/Project/sportTable.json")
        //    .responseJSON { response in
        //    //print(String(response.result.value!.valueForKey("events")!.valueForKey("imm")!))
        //    do{
        //    let jsonResult : NSDictionary = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        //    var a = jsonResult.valueForKey("events")!
        //    var events = [DataToPass]()
        //    for i in 0...jsonResult.valueForKey("events")!.count-1 {
        //    //print((a[i].valueForKey("type")! as! String)+(a[i].valueForKey("e_date")! as! String)+(a[i].valueForKey("time")! as! String)+(a[i].valueForKey("f_time")! as! String)+(a[i].valueForKey("place")! as! String)+(a[i].valueForKey("author")! as! String)+(a[i].valueForKey("price")! as! String)+(a[i].valueForKey("latitude")! as! String)+(a[i].valueForKey("longitude")! as! String)+(a[i].valueForKey("bg")! as! String)+(a[i].valueForKey("attendant")! as! String)+(a[i].valueForKey("max")! as! String)+(a[i].valueForKey("pic")! as! String))
        //    events.append(DataToPass(type:jsonResult.valueForKey("events")![i].valueForKey("type")! as! String,date:jsonResult.valueForKey("events")![i].valueForKey("e_date")! as! String,time:jsonResult.valueForKey("events")![i].valueForKey("time")! as! String,f_time:jsonResult.valueForKey("events")![i].valueForKey("f_time")! as! String,place:jsonResult.valueForKey("events")![i].valueForKey("place")! as! String,author:jsonResult.valueForKey("events")![i].valueForKey("author")! as! String,price:jsonResult.valueForKey("events")![i].valueForKey("price")! as! String,latitude:jsonResult.valueForKey("events")![i].valueForKey("latitude")! as! String,longitude:jsonResult.valueForKey("events")![i].valueForKey("longitude")! as! String,bg:jsonResult.valueForKey("events")![i].valueForKey("bg")! as! String,attendant:jsonResult.valueForKey("events")![i].valueForKey("attendant")! as! String,max:jsonResult.valueForKey("events")![i].valueForKey("max")! as! String,pic:jsonResult.valueForKey("events")![i].valueForKey("pic")! as! String))
        //    }
        //    self.searchResult = events
        //    }catch{
        //
        //    }
        //
        //    }
        self.events = [DataToPass]()
        self.searchResult = [DataToPass]()
        let urlPath: String = "http://localhost:3000/getEvent"
        var url: NSURL = NSURL(string: urlPath)!
        var request1: NSURLRequest = NSURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse? >= nil
        var error: NSErrorPointer = nil
        do{
            var dataVal: NSData =  try NSURLConnection.sendSynchronousRequest(request1, returningResponse: response)
            var jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            print("Synchronous \(jsonResult)")
            if jsonResult.count>0{
                for i in 0...jsonResult.count-1 {
                    let data :DataToPass = DataToPass(type:jsonResult.valueForKey("type")[i] as! String,date:jsonResult.valueForKey("startTime")[i] as! String,time:jsonResult.valueForKey("startTime")[i] as! String,f_time:jsonResult.valueForKey("finishTime")[i] as! String,place:jsonResult.valueForKey("place")[i] as! String,author:jsonResult.valueForKey("author")[i] as! String,price:jsonResult.valueForKey("price")[i] as! Int,image:jsonResult.valueForKey("image")[i] as! String,latitude:jsonResult.valueForKey("latitude")[i] as! Double,longitude:jsonResult.valueForKey("longitude")[i] as! Double,bg:jsonResult.valueForKey("bg")[i] as! String,join:jsonResult.valueForKey("joinPerson")[i] as! NSArray,max:jsonResult.valueForKey("maxPerson")[i] as! Int,pic:jsonResult.valueForKey("pic")[i] as! String,event_id:jsonResult.valueForKey("_id")[i] as! String,title:jsonResult.valueForKey("description")[i] as! String,createdID:jsonResult.valueForKey("createdId")[i] as! String)
                    events.append(data)
                    //events.append(DataToPass(type: jsonResult.valueForKey("type")[i] as! String,date: jsonResult.valueForKey("startTime")[i] as! String,time:  jsonResult.valueForKey("starttime")[i] as! String,f_time:  jsonResult.valueForKey("finishTime")[i] as! String,place:  jsonResult.valueForKey("place")[i] as! String,author:  jsonResult.valueForKey("author")[i] as! String,price:  jsonResult.valueForKey("price")[i] as! Int,image: jsonResult.valueForKey("image")[i] as! String,latitude: jsonResult.valueForKey("latitude")[i] as! Double,longitude: jsonResult.valueForKey("longitude")[i] as! Double,bg: jsonResult.valueForKey("bg")[i] as! String,join: jsonResult.valueForKey("joinPerson")[i] as! NSArray,max: jsonResult.valueForKey("maxPerson")[i] as! Int,pic:  jsonResult.valueForKey("pic")[i] as! String))
                }
            }
        }catch{
            
        }
        searchResult = events
        var err: NSError
        print(response)
    }

    func search(searchText:String!){
        //        let event1 = DataToPass(type:"Boxing",date:"March 12, 2016",time:"10:40",f_time:"11:40",place:"Chulalongkorn University",author:"Tanakorn Rattanajariya",price:"500",latitude: "13.73888",longitude: "100.52586",bg: "boxing bg",attendant: "1",max:"5",pic:"profilePic")
        //        let event2 = DataToPass(type:"Football",date:"March 13, 2016",time:"12:00",f_time:"14:00",place:"Chulalongkorn University",author:"JJamie Ratchata",price:"120",latitude: "13.73888",longitude: "100.52586",bg: "football bg",attendant: "7",max:"10",pic:"jjamie")
        //        let event3 = DataToPass(type:"Workout",date:"March 14, 2016",time:"11:30",f_time:"12:40",place:"Chulalongkorn University",author:"Chantawat Rattana",price:"700",latitude: "13.73888",longitude: "100.52586",bg: "workout bg",attendant: "5",max:"5",pic:"off")
        //        let event4 = DataToPass(type:"yoga",date:"March 15, 2016",time:"10:30",f_time:"11:40",place:"Chulalongkorn University",author:"Kittinun Kaewtae",price:"300",latitude: "13.73888",longitude: "100.52586",bg: "yoga bg",attendant: "3",max:"5",pic:"best")
        //        events += [event1,event2,event3,event4]
        //        searchResult = events
        //    Alamofire.request(.GET, "http://localhost/Project/sportTable.json")
        //    .responseJSON { response in
        //    //print(String(response.result.value!.valueForKey("events")!.valueForKey("imm")!))
        //    do{
        //    let jsonResult : NSDictionary = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        //    var a = jsonResult.valueForKey("events")!
        //    var events = [DataToPass]()
        //    for i in 0...jsonResult.valueForKey("events")!.count-1 {
        //    //print((a[i].valueForKey("type")! as! String)+(a[i].valueForKey("e_date")! as! String)+(a[i].valueForKey("time")! as! String)+(a[i].valueForKey("f_time")! as! String)+(a[i].valueForKey("place")! as! String)+(a[i].valueForKey("author")! as! String)+(a[i].valueForKey("price")! as! String)+(a[i].valueForKey("latitude")! as! String)+(a[i].valueForKey("longitude")! as! String)+(a[i].valueForKey("bg")! as! String)+(a[i].valueForKey("attendant")! as! String)+(a[i].valueForKey("max")! as! String)+(a[i].valueForKey("pic")! as! String))
        //    events.append(DataToPass(type:jsonResult.valueForKey("events")![i].valueForKey("type")! as! String,date:jsonResult.valueForKey("events")![i].valueForKey("e_date")! as! String,time:jsonResult.valueForKey("events")![i].valueForKey("time")! as! String,f_time:jsonResult.valueForKey("events")![i].valueForKey("f_time")! as! String,place:jsonResult.valueForKey("events")![i].valueForKey("place")! as! String,author:jsonResult.valueForKey("events")![i].valueForKey("author")! as! String,price:jsonResult.valueForKey("events")![i].valueForKey("price")! as! String,latitude:jsonResult.valueForKey("events")![i].valueForKey("latitude")! as! String,longitude:jsonResult.valueForKey("events")![i].valueForKey("longitude")! as! String,bg:jsonResult.valueForKey("events")![i].valueForKey("bg")! as! String,attendant:jsonResult.valueForKey("events")![i].valueForKey("attendant")! as! String,max:jsonResult.valueForKey("events")![i].valueForKey("max")! as! String,pic:jsonResult.valueForKey("events")![i].valueForKey("pic")! as! String))
        //    }
        //    self.searchResult = events
        //    }catch{
        //
        //    }
        //
        //    }
        self.events = [DataToPass]()
        self.searchResult = [DataToPass]()
        let urlPath: String = "http://localhost:3000/searchEvent/"+searchText
        var url: NSURL = NSURL(string: urlPath)!
        var request1: NSURLRequest = NSURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse? >= nil
        var error: NSErrorPointer = nil
        do{
            var dataVal: NSData =  try NSURLConnection.sendSynchronousRequest(request1, returningResponse: response)
            var jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            print("Synchronous \(jsonResult)")
            if jsonResult.count>0{
            for i in 0...jsonResult.count-1 {
                let data :DataToPass = DataToPass(type:jsonResult.valueForKey("type")[i] as! String,date:jsonResult.valueForKey("startTime")[i] as! String,time:jsonResult.valueForKey("startTime")[i] as! String,f_time:jsonResult.valueForKey("finishTime")[i] as! String,place:jsonResult.valueForKey("place")[i] as! String,author:jsonResult.valueForKey("author")[i] as! String,price:jsonResult.valueForKey("price")[i] as! Int,image:jsonResult.valueForKey("image")[i] as! String,latitude:jsonResult.valueForKey("latitude")[i] as! Double,longitude:jsonResult.valueForKey("longitude")[i] as! Double,bg:jsonResult.valueForKey("bg")[i] as! String,join:jsonResult.valueForKey("joinPerson")[i] as! NSArray,max:jsonResult.valueForKey("maxPerson")[i] as! Int,pic:jsonResult.valueForKey("pic")[i] as! String,event_id:jsonResult.valueForKey("_id")[i] as! String,title:jsonResult.valueForKey("description")[i] as! String,createdID:jsonResult.valueForKey("createdId")[i] as! String)
                events.append(data)
                //events.append(DataToPass(type: jsonResult.valueForKey("type")[i] as! String,date: jsonResult.valueForKey("startTime")[i] as! String,time:  jsonResult.valueForKey("starttime")[i] as! String,f_time:  jsonResult.valueForKey("finishTime")[i] as! String,place:  jsonResult.valueForKey("place")[i] as! String,author:  jsonResult.valueForKey("author")[i] as! String,price:  jsonResult.valueForKey("price")[i] as! Int,image: jsonResult.valueForKey("image")[i] as! String,latitude: jsonResult.valueForKey("latitude")[i] as! Double,longitude: jsonResult.valueForKey("longitude")[i] as! Double,bg: jsonResult.valueForKey("bg")[i] as! String,join: jsonResult.valueForKey("joinPerson")[i] as! NSArray,max: jsonResult.valueForKey("maxPerson")[i] as! Int,pic:  jsonResult.valueForKey("pic")[i] as! String))
            }
            }
        }catch{
            
        }
        searchResult = events
        var err: NSError
        print(response)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if (segue.identifier == "pass") {
            
            // initialize new view controller and cast it as your view controller
            let des = segue.destinationViewController as? ShowEventViewController
            // your new view controller should have property that will store passed value
            var indexPath = self.tableView.indexPathForSelectedRow!
            var dataToPass = searchResult[indexPath.row]
            des?.showEvent = dataToPass
            des!.joinPerson = dataToPass.join
        }
        
    }
    // MARK: - Table view data source
    override  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        //        if let imageView = cell.viewWithTag(1) as? UIImageView{
        //        imageView.image = UIImage(named: searchResult[indexPath.row].bg)!.applyBlurWithRadius(3, tintColor: UIColor(white: 0.5, alpha: 0.4), saturationDeltaFactor: 1.8)
        //        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        print(self.searchResult.count)
        if let author = cell.viewWithTag(2) as? UILabel{
            print(self.searchResult[indexPath.row].author)
            author.text = searchResult[indexPath.row].author
        }
        if let place = cell.viewWithTag(3) as? UILabel{
            place.text = searchResult[indexPath.row].place
        }
        if let price = cell.viewWithTag(4) as? UILabel{
            price.text = String(searchResult[indexPath.row].price) + " THB"
        }
        if let date = cell.viewWithTag(5) as? UILabel{
            date.text = searchResult[indexPath.row].date.substringWithRange(Range<String.Index>(start: searchResult[indexPath.row].date.startIndex.advancedBy(0), end: searchResult[indexPath.row].date.endIndex.advancedBy(-14)))
        }
        let attend = cell.viewWithTag(6) as! UILabel
        attend.text = String(searchResult[indexPath.row].join.count) + "/" + String(searchResult[indexPath.row].max)
        var max :Int = searchResult[indexPath.row].max
        var att :Int = searchResult[indexPath.row].join.count
        if max - att == 0 {
            let join = cell.viewWithTag(10) as! UIImageView
            join.image = UIImage(named: "social red")
        }else if 100-((max-att)*100/max) >= 70 {
            let join = cell.viewWithTag(10) as! UIImageView
            join.image = UIImage(named: "social orange")
        }else if 100-((max-att)*100/max) >= 40 {
            let join = cell.viewWithTag(10) as! UIImageView
            join.image = UIImage(named: "social yellow")
        }else{
            let join = cell.viewWithTag(10) as! UIImageView
            join.image = UIImage(named: "social green")
        }
        if let time = cell.viewWithTag(7) as? UILabel{
            time.text = String(searchResult[indexPath.row].time.substringWithRange(Range<String.Index>(start: searchResult[indexPath.row].time.startIndex.advancedBy(11), end: searchResult[indexPath.row].time.endIndex.advancedBy(-8)))
                )+"-"+searchResult[indexPath.row].f_time.substringWithRange(Range<String.Index>(start: searchResult[indexPath.row].f_time.startIndex.advancedBy(11), end: searchResult[indexPath.row].f_time.endIndex.advancedBy(-8)))
        }
        if let icon = cell.viewWithTag(8) as? UIImageView{
            icon.image = UIImage(named: searchResult[indexPath.row].image)
        }
        if let type = cell.viewWithTag(9) as? UILabel{
            type.text = String(searchResult[indexPath.row].type).uppercaseString
        }
        if let views = cell.viewWithTag(11) as! UIView?{
//            if searchResult[indexPath.row].type == "Boxing"{
//                views.backgroundColor = UIColor(red: 232/255, green: 107/255, blue: 107/255, alpha: 1.0)
//            }else if searchResult[indexPath.row].type == "Football"{
//                views.backgroundColor = UIColor(red: 64/255, green: 78/255, blue: 112/255, alpha: 1.0)
//            }else if searchResult[indexPath.row].type == "Workout"{
//                views.backgroundColor = UIColor(red: 209/255, green: 157/255, blue: 79/255, alpha: 1.0)
//            }else if searchResult[indexPath.row].type == "Yoga"{
//                views.backgroundColor = UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1.0)
//            }
        }
        let tt = cell.viewWithTag(12) as! UILabel
        tt.text = searchResult[indexPath.row].title
        
        //        let back :UIView = UIView(frame: cell.frame)
        //        back.backgroundColor = UIColor(colorLiteralRed:171, green: 171, blue: 171, alpha: 1)
        //        cell.selectedBackgroundView = back
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
}
