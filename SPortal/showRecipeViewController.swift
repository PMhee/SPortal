//
//  showRecipeViewController.swift
//  SPortal
//
//  Created by Tanakorn on 4/4/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
class showRecipeViewController: UIViewController {
    var user = [User]()
    var urlPath : String!
    var user_id : String!
    @IBOutlet var userName: UILabel!
    @IBOutlet var place: UILabel!
    @IBOutlet var priceTotal: UILabel!
    @IBOutlet var price1: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var logo: UIImageView!
    @IBOutlet var type: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.urlPath = "http://localhost:3000/getProfile/"+self.user_id
        getProfile()
        self.userName.text = self.user[0].receipt[self.user[0].receipt.count-1].valueForKey("name") as! String
        self.place.text = self.user[0].receipt[self.user[0].receipt.count-1].valueForKey("place") as! String
        self.priceTotal.text = String(self.user[0].receipt[self.user[0].receipt.count-1].valueForKey("price") as! Int)
        self.price.text = String(self.user[0].receipt[self.user[0].receipt.count-1].valueForKey("price") as! Int) + " THB"
        self.price1.text = String(self.user[0].receipt[self.user[0].receipt.count-1].valueForKey("price") as! Int)
        self.date.text = (self.user[0].receipt[self.user[0].receipt.count-1].valueForKey("date") as! String).substringWithRange(Range<String.Index>(start: (self.user[0].receipt[self.user[0].receipt.count-1].valueForKey("date") as! String).startIndex.advancedBy(0), end: (self.user[0].receipt[self.user[0].receipt.count-1].valueForKey("date") as! String).endIndex.advancedBy(-14))) + " "+(self.user[0].receipt[self.user[0].receipt.count-1].valueForKey("date") as! String).substringWithRange(Range<String.Index>(start: (self.user[0].receipt[self.user[0].receipt.count-1].valueForKey("date") as! String).startIndex.advancedBy(11), end: (self.user[0].receipt[self.user[0].receipt.count-1].valueForKey("date") as! String).endIndex.advancedBy(-8)))
        logo.layer.cornerRadius = 10
        self.type.text = self.user[0].receipt[self.user[0].receipt.count-1].valueForKey("event") as! String
        // Do any additional setup after loading the view.
    }
    func getProfile(){
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
            
        }catch{
            
        }
        var err: NSError
        print(response)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
