//
//  ShowEventViewController.swift
//  SPortal
//
//  Created by Tanakorn on 2/27/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import FBSDKLoginKit
import FBSDKCoreKit
class ShowEventViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate,UIScrollViewDelegate  {
    
    @IBOutlet weak var viewPlayer: UIButton!
    @IBOutlet weak var views: UIButton!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var join: UIButton!
    @IBOutlet weak var attend: UILabel!
    @IBOutlet weak var users: UIImageView!
    @IBOutlet weak var place: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBAction func clickJoin(sender: UIButton) {
        joinEvent()
    }
    var key : String!
    let imageArray = ["weight bg","football bg","yoga bg","boxing bg"]
    let locationManager = CLLocationManager()
    var showEvent:DataToPass!
    var user_id : String!
    var userName : String!
    var firstName : String!
    var joinPerson : NSArray!
    var events = [DataToPass]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(.GET, "http://localhost:3000/requestCsrf")
            .responseString { response in
                print("Response String: \(response.result.value)")
                self.key = String(response.result.value!)
                print(self.key)
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        addEvent()
        returnUserData()
        scroll.delegate = self
        background.image = UIImage(named: showEvent.bg)!//.applyBlurWithRadius(3, tintColor: UIColor(white: 0.5, alpha: 0.7), saturationDeltaFactor: 1.8)
        profilePic.image = UIImage(named: showEvent.pic)
        profilePic.layer.masksToBounds = false
        profilePic.layer.cornerRadius = profilePic.frame.height/2
        profilePic.clipsToBounds = true
        if self.events.count > 0{
        self.attend.text = String(self.events[0].join.count)+"/"+String(showEvent.max)
        }else{
        self.attend.text = String(showEvent.join.count)+"/"+String(showEvent.max)
        }
        //        var max :Int = Int(showEvent.max)!
        //        var att :Int = Int(showEvent.attendant)!
        //        if max - att == 0 {
        //            let join = users as UIImageView
        //            join.image = UIImage(named: "social red")
        //
        //        }else if 100-((max-att)*100/max) >= 70 {
        //            let join = users as UIImageView
        //            join.image = UIImage(named: "social orange")
        //        }else if 100-((max-att)*100/max) >= 30 {
        //            let join = users as UIImageView
        //            join.image = UIImage(named: "social yellow")
        //        }else{
        //            let join = users as UIImageView
        //            join.image = UIImage(named: "social green")
        //        }
        map.layer.cornerRadius = 20
        self.name.text = showEvent.author
        self.place.setTitle(showEvent.place, forState: .Normal)
        //self.price.text = showEvent.price
        self.date.text = "Date: "+showEvent.date.substringWithRange(Range<String.Index>(start: showEvent.date.startIndex.advancedBy(0), end: showEvent.date.endIndex.advancedBy(-14)))+" Time: "+showEvent.date.substringWithRange(Range<String.Index>(start: showEvent.time.startIndex.advancedBy(11), end: showEvent.time.endIndex.advancedBy(-8)))+"-"+showEvent.f_time.substringWithRange(Range<String.Index>(start: showEvent.f_time.startIndex.advancedBy(11), end: showEvent.f_time.endIndex.advancedBy(-8)))
        self.type.text = showEvent.type.uppercaseString
        //image.image = UIImage(named: showEvent.image)
        // Do any additional setup after loading the view.
        let spot = MKPointAnnotation()
        spot.coordinate.latitude = showEvent.latitude
        spot.coordinate.longitude = showEvent.longitude
        self.map.addAnnotation(spot)
        locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        join.hidden = true
        
    }
    func addEvent(){
        let urlPath: String = "http://localhost:3000/updatePlayer/"+self.showEvent.event_id
        var url: NSURL = NSURL(string: urlPath)!
        var request1: NSURLRequest = NSURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse? >= nil
        var error: NSErrorPointer = nil
        do{
            var dataVal: NSData =  try NSURLConnection.sendSynchronousRequest(request1, returningResponse: response)
            var jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            print("Synchronous \(jsonResult)")
            if jsonResult.count>0{
                    let data :DataToPass = DataToPass(type:jsonResult.valueForKey("type")! as! String,date:jsonResult.valueForKey("startTime")! as! String,time:jsonResult.valueForKey("startTime")! as! String,f_time:jsonResult.valueForKey("finishTime")! as! String,place:jsonResult.valueForKey("place")! as! String,author:jsonResult.valueForKey("author")! as! String,price:jsonResult.valueForKey("price")! as! Int,image:jsonResult.valueForKey("image")! as! String,latitude:jsonResult.valueForKey("latitude")! as! Double,longitude:jsonResult.valueForKey("longitude")! as! Double,bg:jsonResult.valueForKey("bg")! as! String,join:jsonResult.valueForKey("joinPerson")! as! NSArray,max:jsonResult.valueForKey("maxPerson")! as! Int,pic:jsonResult.valueForKey("pic")! as! String,event_id:jsonResult.valueForKey("_id")! as! String,title:jsonResult.valueForKey("description")! as! String,createdID:jsonResult.valueForKey("createdId")! as! String)
                    events.append(data)
                    //events.append(DataToPass(type: jsonResult.valueForKey("type")[i] as! String,date: jsonResult.valueForKey("startTime")[i] as! String,time:  jsonResult.valueForKey("starttime")[i] as! String,f_time:  jsonResult.valueForKey("finishTime")[i] as! String,place:  jsonResult.valueForKey("place")[i] as! String,author:  jsonResult.valueForKey("author")[i] as! String,price:  jsonResult.valueForKey("price")[i] as! Int,image: jsonResult.valueForKey("image")[i] as! String,latitude: jsonResult.valueForKey("latitude")[i] as! Double,longitude: jsonResult.valueForKey("longitude")[i] as! Double,bg: jsonResult.valueForKey("bg")[i] as! String,join: jsonResult.valueForKey("joinPerson")[i] as! NSArray,max: jsonResult.valueForKey("maxPerson")[i] as! Int,pic:  jsonResult.valueForKey("pic")[i] as! String))
                
            }
        }catch{
            print("catch")
        }
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
                self.join.layer.cornerRadius = 5
                if self.user_id == self.showEvent.join[0].valueForKey("user_id") as! String{
                    self.join.setTitle("Cancel", forState: .Normal)
                }else{
                    self.join.setTitle("JOIN (\(self.showEvent.price) THB)", forState: .Normal)
                }
                self.join.hidden = false
            }
        })
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        //print(scrollView.contentOffset.y + scrollView.contentOffset.x)
//        if (scrollView.contentOffset.y != 0) {
//            var offset:CGPoint = scrollView.contentOffset
//            offset.y = 0
//            scrollView.contentOffset = offset
//        }
        if (scrollView.contentOffset.x != 0) {
            var offset:CGPoint = scrollView.contentOffset
            offset.x = 0
            scrollView.contentOffset = offset        }
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: showEvent.latitude, longitude:showEvent.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        print(region)
        self.map.setRegion(region, animated: true)
        //self.locationManager.stopUpdatingLocation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        var view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
        } else {
            // 3
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }
        return view
    }
    func joinEvent(){
        var firstName:String = self.userName
        var range: Range<String.Index> = firstName.rangeOfString(" ")!
        var index: Int = firstName.startIndex.distanceTo(range.startIndex)
        let parameters = ["message":["user_id":self.user_id,"eventId":showEvent.event_id,"name":self.userName,"firstName":firstName.substringWithRange(Range<String.Index>(start: firstName.startIndex.advancedBy(0), end: firstName.startIndex.advancedBy(index)))],"_csrf":self.key]
        print(parameters)
        let date = NSDate()
        var day = (String(date).substringWithRange(Range<String.Index>(start: String(date).startIndex.advancedBy(0), end: String(date).startIndex.advancedBy(10))))
        var hour = (String(date).substringWithRange(Range<String.Index>(start: String(date).startIndex.advancedBy(11), end: String(date).startIndex.advancedBy(19))))
        
        let param = [
            
            "noti" : ["user_id":showEvent.createdID,"date":day+"T"+hour+".000Z","name":self.userName,"title":"Joined your event","image":self.firstName],"_csrf":self.key
        ]
        var found = 0
        for i in 0...showEvent.join.count-1{
            print(showEvent.join[i])
            if self.user_id == showEvent.join[i].valueForKey("user_id") as! String {
                print("found")
                found++
            }
        }
        print("found"+String(found))
        if found==0{
            print("hello")
            Alamofire.request(.POST, "http://localhost:3000/joinEvent", parameters:parameters as! [String : AnyObject], encoding: .JSON)
            Alamofire.request(.POST, "http://localhost:3000/addNewNotification", parameters:param as! [String : AnyObject], encoding: .JSON)
        }else{
            let alertController = UIAlertController(title: "Warning", message:
                "You want to cancle this Event?", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                print("Handle Ok logic here")
                let parameters = ["message":["eventId":self.showEvent.event_id],"_csrf":self.key]
                Alamofire.request(.POST, "http://localhost:3000/removeEvent", parameters:parameters as! [String : AnyObject], encoding: .JSON)
                self.navigationController?.popToRootViewControllerAnimated(true)
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let des = segue.destinationViewController as? showSportPlayerTableViewController{
            des.joined = self.events[0].join
            des.eventID = self.showEvent.event_id
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
