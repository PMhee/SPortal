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
    //new
    @IBOutlet weak var views: UIView!
    @IBOutlet var image_profile_picture_back: UIImageView!
    
    @IBOutlet var image_profile_picture_front: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Blur image_profile_picture_back
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        image_profile_picture_back.addSubview(blurEffectView)
        
        //Set image_profile_picture_back to circle
        image_profile_picture_front.layer.masksToBounds = false
        image_profile_picture_front.layer.cornerRadius = image_profile_picture_front.frame.height/2
        image_profile_picture_front.clipsToBounds = true

        
        
        // Do any additional setup after loading the view.
//        profilePicSmall.layer.masksToBounds = false
//        profilePicSmall.layer.cornerRadius = 55
//        profilePicSmall.clipsToBounds = true
//        self.spinner.startAnimating()
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//        
//        })
        returnUserData()
//        let blurEffect = UIBlurEffect(style: .Light)
//        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
//        blurredEffectView.frame = CGRectMake(0, 0, 400 , 204)
//        blurredEffectView.alpha = 0.7
//        profilePic.addSubview(blurredEffectView)
        
        
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
                    let fname : NSString = result.valueForKey("name") as! NSString
                    self.name.text = fname as String
//                    let sex : NSString = result.valueForKey("gender") as! NSString
//                    self.gender.text = sex as String
                    let userID : NSString = result.valueForKey("id") as! NSString
                    let facebookProfileUrl = NSURL(string: "http://graph.facebook.com/\(userID)/picture?type=large")
                    if let data = NSData(contentsOfURL: facebookProfileUrl!) {
                        self.image_profile_picture_front.image = UIImage(data: data)
                        self.image_profile_picture_back.image = UIImage(data: data)
//                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                            
//                            self.spinner.stopAnimating()
//                            self.spinner.hidden = true
//                        })
                        
                    }
                    
                }
            })
            
        }
    }
  
    
    
   
}
