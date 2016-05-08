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
import Alamofire

class OtherViewController: UIViewController,UIScrollViewDelegate,UITextViewDelegate{
    
    @IBOutlet weak var loved: UILabel!
    @IBOutlet weak var add: UIButton!
    var key:String!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UILabel!
    var actual_id : String!
    @IBOutlet weak var scrollView: UIScrollView!
    var userID:String!
    @IBOutlet var edit: UIButton!
    var user = [User]()
    @IBOutlet var favourite2: UILabel!
    @IBOutlet var favourite3: UILabel!
    @IBOutlet var favourite1: UILabel!
    @IBOutlet var about: UITextView!
    //new
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_job: UILabel!
    @IBOutlet weak var stackview_people_like: UIStackView!
    @IBOutlet weak var favouriteIcon3: UIImageView!
    @IBOutlet weak var favouriteIcon2: UIImageView!
    @IBOutlet weak var favouriteIcon1: UIImageView!
    @IBOutlet var image_profile_picture_back: UIImageView!
    var i = 0
    @IBAction func addFriend(sender: UIButton) {
        self.addFriend()
    }
    @IBAction func editAbout(sender: UIButton) {
        if i % 2 == 0{
            self.about.editable = true
            self.about.selectable = true
            self.about.becomeFirstResponder()
            self.edit.setTitle("Save", forState: .Normal)
        }else{
            let parameter = [
                "message" : ["user_id":self.userID,"about":self.about.text],"_csrf":self.key
            ]
            Alamofire.request(.POST, "http://localhost:3000/addAboutme", parameters:parameter as! [String : AnyObject], encoding: .JSON)
            self.about.editable = false
            self.about.selectable = false
            self.edit.setTitle("Edit", forState: .Normal)
        }
        i++
    }
    @IBOutlet var image_profile_picture_front: UIImageView!
    
    var friends = [Friend]()
    override func viewDidLoad() {
        super.viewDidLoad()
        add.layer.cornerRadius = 5
        Alamofire.request(.GET, "http://localhost:3000/requestCsrf")
            .responseString { response in
                print("Response String: \(response.result.value)")
                self.key = String(response.result.value!)
                print(self.key)
        }
        scrollView.delegate = self
        
        //about.delegate = self
        print("bounds"+String(scrollView.bounds))
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
                print("fetched users: \(result)")
                self.actual_id = result.valueForKey("id")! as! String
                print(self.actual_id)
                print(self.user[0].UserID)
                if self.actual_id == self.user[0].UserID{
                    self.edit.hidden = false
                }
                var found : Int = 0
                if self.friends.count > 0{
                    for i in 0...self.friends.count-1{
                        
                        if self.actual_id == self.friends[i].user_id{
                            found++
                        }
                        
                    }
                        if found > 0 {
                            self.add.setTitle("REMOVE FRIEND", forState: .Normal)
                            self.add.hidden = false
                        }else{
                            if self.actual_id == self.userID {
                                self.add.hidden = true
                            }else{
                            self.add.setTitle("ADD FRIEND", forState: .Normal)
                            self.add.hidden = false
                            }
                        }
                    
                }else{
                    self.add.setTitle("ADD FRIEND", forState: .Normal)
                    self.add.hidden = false
                }
            }
        })
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        getProfile()
        returnUserData()
        label_name.text = self.user[0].Username
        var image_blur = UIImage!()
        image_blur = UIImage(named: self.user[0].profilePic)!.applyBlurWithRadius(3, tintColor: UIColor(white: 0.5, alpha: 0.4), saturationDeltaFactor: 1.8)
        self.image_profile_picture_back.image = image_blur
        self.image_profile_picture_front.image = UIImage(named: self.user[0].profilePic)
        scrollViewDidScroll(scrollView)
        scrollView.directionalLockEnabled = true
        setScreen()
        favouriteIcon1.image = UIImage(named:favourite1.text!+" icon black")
        favouriteIcon2.image = UIImage(named:favourite2.text!+" icon black")
        favouriteIcon3.image = UIImage(named:favourite3.text!+" icon black")
        about.text = self.user[0].About
        about.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        about.font = UIFont(name: "Helvetica Neue Condensed Bold", size: 12)

    }
    func addFriend(){
        var found = 0
        if self.friends.count > 0{
            for i in 0...self.friends.count-1{
                if self.actual_id == self.friends[i].user_id{
                    found++
                }
                if found > 0 {
                    if self.actual_id == self.userID{
                        self.add.hidden = true
                    }else{
                    self.add.setTitle("ADD FRIEND", forState: .Normal)
                    var param = ["message" : ["facebookId":self.actual_id,"user_id":self.userID],"_csrf":self.key
                    ]
                    Alamofire.request(.POST, "http://localhost:3000/removeFriend", parameters:param as! [String : AnyObject], encoding: .JSON)
                    param = ["message" : ["facebookId":self.userID,"user_id":self.actual_id],"_csrf":self.key
                    ]
                    Alamofire.request(.POST, "http://localhost:3000/removeFriend", parameters:param as! [String : AnyObject], encoding: .JSON)
                    }
                }else{
                    self.add.setTitle("REMOVE FRIEND", forState: .Normal)
                    var param = ["message" : ["facebookId":self.actual_id,"user_id":self.userID],"_csrf":self.key
                    ]
                    Alamofire.request(.POST, "http://localhost:3000/addFriend", parameters:param as! [String : AnyObject], encoding: .JSON)
                    param = ["message" : ["facebookId":self.userID,"user_id":self.actual_id],"_csrf":self.key
                    ]
                    Alamofire.request(.POST, "http://localhost:3000/addFriend", parameters:param as! [String : AnyObject], encoding: .JSON)
                }
            }
        }else{
            if self.actual_id == self.userID{
                self.add.hidden = true
            }else{
            self.add.setTitle("REMOVE FRIEND", forState: .Normal)
                self.add.hidden = false
            var param = ["message" : ["facebookId":self.actual_id,"user_id":self.userID],"_csrf":self.key
            ]
            Alamofire.request(.POST, "http://localhost:3000/addFriend", parameters:param as! [String : AnyObject], encoding: .JSON)
            param = ["message" : ["facebookId":self.userID,"user_id":self.actual_id],"_csrf":self.key
            ]
            Alamofire.request(.POST, "http://localhost:3000/addFriend", parameters:param as! [String : AnyObject], encoding: .JSON)
            }
        }
    }
    func getProfile(){
        self.user = [User]()
        let urlPath: String = "http://localhost:3000/getProfile/"+self.userID
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
            let data :User = User(UserID:jsonResult.valueForKey("facebookId") as? String,Username:jsonResult.valueForKey("displayName") as? String,profilePic:firstName.substringWithRange(Range<String.Index>(start: firstName.startIndex.advancedBy(0), end: firstName.startIndex.advancedBy(index))),achievement:jsonResult.valueForKey("achievement") as? NSArray,notification:jsonResult.valueForKey("notification") as? NSArray,friends:jsonResult.valueForKey("friends") as? NSArray,favourite:jsonResult.valueForKey("favorite") as? NSArray,About:jsonResult.valueForKey("about") as! String,newNotification:jsonResult.valueForKey("newNotification") as? NSArray,receipt:jsonResult.valueForKey("receipt") as? NSArray,stat:jsonResult.valueForKey("stat") as? NSArray,newFeed:jsonResult.valueForKey("newFeed") as? NSArray)
            self.user.append(data)
            if self.user[0].friends.count > 0{
            for i in 0...self.user[0].friends.count-1{
                let friend = Friend(user_id:self.user[0].friends[i].valueForKey("user_id") as! String)
                self.friends.append(friend)
            }
            }
            var sum = 0
            if self.user[0].stat != nil{
            for i in 0...self.user[0].stat.count-1{
                sum += self.user[0].stat[i].valueForKey("commented") as! Int
            }
            }
            self.loved.text = String(sum)
        }catch{
            
        }
        var err: NSError
        print(response)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        print(scrollView.contentOffset.y + scrollView.contentOffset.x)
        //        if (scrollView.contentOffset.y != 0) {
        //            var offset:CGPoint = scrollView.contentOffset
        //            offset.y = 0
        //            scrollView.contentOffset = offset
        //        }
        var offset:CGPoint = scrollView.contentOffset
        
        if (scrollView.contentOffset.y == -64){
            offset.y = 0
            scrollView.contentOffset = offset
        }
        if (scrollView.contentOffset.x != 0) {
            
            offset.x = 0
            scrollView.contentOffset = offset        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let des = segue.destinationViewController as? FriendsTableViewController{
            print(self.user[0].friends)
            if self.friends.count > 0{
            des.friends = self.friends
            }else{
                des.friends = [Friend]()
            }
        }
        if let des = segue.destinationViewController as? AchievementTableViewController{
            des.userID = self.user[0].UserID
        }
        if let des = segue.destinationViewController as? ReceiptTableViewController{
            if self.user[0].receipt != nil{
            des.size = self.user[0].receipt.count
            }else{
                des.size = 0
            }
        }
        if let des = segue.destinationViewController as? StatViewController{
            des.user_id = self.user[0].UserID
        }
        
    }
    
    func setScreen(){
        
        //Set image_profile_picture_back to circle
        image_profile_picture_front.layer.masksToBounds = false
        image_profile_picture_front.layer.cornerRadius = 60
        image_profile_picture_front.clipsToBounds = true
        
        //set border label
        if self.user[0].favourite != nil{
        favourite1.text = self.user[0].favourite[0] as! String
        favourite2.text = self.user[0].favourite[1] as! String
        favourite3.text = self.user[0].favourite[2] as! String
        }else{
            favourite1.text = "default"
            favourite2.text = "default"
            favourite3.text = "default"
        }
//        favourite1.layer.borderWidth = 1.0
//        favourite1.layer.cornerRadius = 3
//        favourite1.layer.borderColor = UIColor.redColor().CGColor
//        favourite2.layer.borderWidth = 1.0
//        favourite2.layer.cornerRadius = 3
//        
//        favourite2.layer.borderColor = UIColor.redColor().CGColor
//        favourite3.layer.borderWidth = 1.0
//        favourite3.layer.cornerRadius = 3
//        favourite3.layer.borderColor = UIColor.redColor().CGColor
        
        
    }
    
    
    
}
