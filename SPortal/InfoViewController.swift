//
//  InfoViewController.swift
//  SPortal
//
//  Created by Tanakorn on 1/22/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
class InfoViewController: UIViewController{
    
   
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UILabel!
   

    
    //new

    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_job: UILabel!
    
    @IBOutlet weak var stackview_people_like: UIStackView!
    
    @IBOutlet var image_profile_picture_back: UIImageView!
    
    @IBOutlet var image_profile_picture_front: UIImageView!
    
    //prototype
    @IBOutlet weak var label_football: UILabel!
    @IBOutlet weak var label_basketball: UILabel!
    @IBOutlet weak var label_batminton: UILabel!
    var friends = [Friend]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setScreen()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
        })
        returnUserData()
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                        let userID : NSString = userNameArray[i].valueForKey("id") as! NSString
                        let facebookProfileUrl = NSURL(string: "http://graph.facebook.com/\(userID)/picture?type=large")
                        if let data = NSData(contentsOfURL: facebookProfileUrl!) {
                            //   self.friendImage.image = UIImage(data: data)
                            self.friends.append(Friend(image_profile: UIImage(data:data),name:userNameArray[i].valueForKey("name") as! String))
                        }
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
                    self.label_name.text = name as String
                    //                    let sex : NSString = result.valueForKey("gender") as! NSString
                    //                    self.gender.text = sex as String
                    let userID : NSString = result.valueForKey("id") as! NSString
                    let facebookProfileUrl = NSURL(string: "http://graph.facebook.com/\(userID)/picture?type=large")
                    if let data = NSData(contentsOfURL: facebookProfileUrl!) {
                        var image_blur: UIImage!
                        image_blur = UIImage(data: data)!.applyBlurWithRadius(3, tintColor: UIColor(white: 0.5, alpha: 0.4), saturationDeltaFactor: 1.8)
                        self.image_profile_picture_back.image = image_blur
                        self.image_profile_picture_front.image = UIImage(data: data)
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.label_name.hidden = false
                            self.label_job.hidden = false
                            self.stackview_people_like.hidden = false
                            
                        })
                        
                    }
                    
                }
            })
            
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let des = segue.destinationViewController as? FriendsTableViewController{
            des.friends = self.friends
        }
    }
    
    func setScreen(){

        //Set image_profile_picture_back to circle
        image_profile_picture_front.layer.masksToBounds = false
        image_profile_picture_front.layer.cornerRadius = 60
        image_profile_picture_front.clipsToBounds = true
        
        //set border label
        label_football.layer.borderWidth = 1.0
        label_football.layer.cornerRadius = 3
        label_football.layer.borderColor = UIColor.redColor().CGColor
        label_basketball.layer.borderWidth = 1.0
        label_basketball.layer.cornerRadius = 3
        
        label_basketball.layer.borderColor = UIColor.redColor().CGColor
        label_batminton.layer.borderWidth = 1.0
        label_batminton.layer.cornerRadius = 3
        label_batminton.layer.borderColor = UIColor.redColor().CGColor
        
        
        //set hidden  layer
        self.label_name.hidden = true
        self.label_job.hidden = true
        self.stackview_people_like.hidden = true
        
       
    }
    
    
    
}
