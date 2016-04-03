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
    var friends = [Friend]()
    var key:String!
    var user_id: String!
    var user_name: String!
    @IBAction func click(sender: UIButton) {
        createUser()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(.GET, "http://localhost:3000/requestCsrf")
            .responseString { response in
                print("Response String: \(response.result.value)")
                self.key = String(response.result.value!)
                print(self.key)
        }
        returnUserData()
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
        let parameters = ["message":["facebookId":self.user_id,"displayName":self.user_name],"_csrf":self.key]
        Alamofire.request(.POST, "http://localhost:3000/addUser", parameters: parameters as! [String : AnyObject], encoding: .JSON)
        let param = ["message":["user_id":self.user_id,"date":"2016-04-28T10:00:00.000Z","title":"New Star","checked":false],"_csrf":self.key]
        Alamofire.request(.POST, "http://localhost:3000/addAchievement", parameters: param as! [String : AnyObject], encoding: .JSON)
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
                        let f :Friend = Friend(image_profile:firstName.substringWithRange(Range<String.Index>(start: firstName.startIndex.advancedBy(0), end: firstName.startIndex.advancedBy(index))),name:name)
                        self.friends.append(f)
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
                    
                }
            })
            
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
