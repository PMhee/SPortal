//
//  addUserViewController.swift
//  SPortal
//
//  Created by Tanakorn on 4/3/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import Alamofire
import FBSDKLoginKit
import FBSDKCoreKit
class addUserViewController: UIViewController {
    var friends = [String]()
    var key:String!
    var user_id: String!
    var user_name: String!
    var user = [User]()
    
    struct Achievement {
        var title : String
        var date : String
        var checked : String
    }
    struct F {
        var user_id : String!
    }
    var friend = [F]()
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(.GET, "http://localhost:3000/requestCsrf")
            .responseString { response in
                print("Response String: \(response.result.value)")
                self.key = String(response.result.value!)
                print(self.key)
        }
            self.returnUserData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createUser(){
        NSNotificationCenter.defaultCenter().postNotificationName("sendNotificationID", object: nil)
        let workplace = "add your workplace"
        let about = ""
        let noti = []
        let parameters = ["message":["facebookId":self.user_id,"displayName":self.user_name,"notification":noti,"newNotification":noti],"_csrf":self.key]
        Alamofire.request(.POST, "http://localhost:3000/addUser", parameters: parameters as! [String : AnyObject], encoding: .JSON)
        let a1 = Achievement(title:"Man of the match",date:"2016-04-28T10:00:00.000Z",checked:"false")
        let a2 = Achievement(title:"Join Lenkila 10 times",date:"2016-04-28T10:00:00.000Z",checked:"false")
        let a3 = Achievement(title:"Target achieved",date:"2016-04-28T10:00:00.000Z",checked:"false")
        let a4 = Achievement(title:"Best pace",date:"2016-04-28T10:00:00.000Z",checked:"false")
        let a5 = Achievement(title:"Superstar of Lenkila",date:"2016-04-28T10:00:00.000Z",checked:"false")
        let a6 = Achievement(title:"Longest distance",date:"2016-04-28T10:00:00.000Z",checked:"false")
        let a7 = Achievement(title:"You will never walk alone",date:"2016-04-28T10:00:00.000Z",checked:"false")
        var achievement = [Achievement]()
        achievement += [a1,a2,a3,a4,a5,a6,a7]
        print(achievement.count)
//        for i in 0...self.friends.count-1{
//            let f = F(user_id: self.friends[i])
//            self.friend.append(f)
//        }
        for i in 0...achievement.count-1{
        let param = ["message":["user_id":self.user_id,"date":achievement[i].date,"title":achievement[i].title,"checked":achievement[i].checked],"_csrf":self.key]
        Alamofire.request(.POST, "http://localhost:3000/addAchievement", parameters: param as! [String : AnyObject], encoding: .JSON)
        }
        self.performSegueWithIdentifier("goInfom", sender: self)
       }
    func returnUserData()
    {
        // Get List Of Friends
        
        let fbRequest = FBSDKGraphRequest(graphPath:"/me/friends", parameters:nil);
        fbRequest.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
            
            if error == nil {
                if let userNameArray : NSArray = result.valueForKey("data") as? NSArray
                {
                    for i in 0...userNameArray.count-1
                    {
                        print(userNameArray[i].valueForKey("id"))
                        print(userNameArray[i].valueForKey("name"))
                        let name : String = userNameArray[i].valueForKey("name") as! String
                        let userID : NSString = userNameArray[i].valueForKey("id") as! NSString
                        let facebookProfileUrl = NSURL(string: "http://graph.facebook.com/\(userID)/picture?type=large")
                        var firstName:String = name
                        var range: Range<String.Index> = firstName.rangeOfString(" ")!
                        var index: Int = firstName.startIndex.distanceTo(range.startIndex)
                        
                    }
                }
                else {
                    
                    print("Error Getting Friends \(error)");
                    
                }
            }
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
                    //                    let age_range : NSDictionary = result.valueForKey("age_range") as! NSDictionary
                    //                    self.age.text = age_range["min"]?.stringValue
                    let name : NSString = result.valueForKey("name") as! NSString
                    self.user_name = name as String
                    //                    let sex : NSString = result.valueForKey("gender") as! NSString
                    //                    self.gender.text = sex as String
                    let userID : NSString = result.valueForKey("id") as! NSString
                    self.user_id = userID as String
                    
                    let facebookProfileUrl = NSURL(string: "http://graph.facebook.com/\(userID)/picture?type=large")
                    if let data = NSData(contentsOfURL: facebookProfileUrl!) {
                        var image_blur: UIImage!
                        image_blur = UIImage(data: data)!.applyBlurWithRadius(3, tintColor: UIColor(white: 0.5, alpha: 0.4), saturationDeltaFactor: 1.8)
                    }
                    self.createUser()
                    self.performSegueWithIdentifier("goInfom", sender: self)
                    
                }
            })
          
        }
    }
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
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
