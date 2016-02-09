//
//  StatViewController.swift
//  SPortal
//
//  Created by Tanakorn on 1/25/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class StatViewController: UIViewController {

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var step: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet var age: UILabel!
    @IBOutlet var gender: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var graph: GraphView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBAction func set(sender: UIButton) {
        textfield.hidden = true
        type.hidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.spinner.startAnimating()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
        })
        returnUserData()
        // Do any additional setup after loading the view.
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func returnUserData()
    {
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
                
                let age_range : NSDictionary = result.valueForKey("age_range") as! NSDictionary
                self.age.text = age_range["min"]?.stringValue
                let sex : NSString = result.valueForKey("gender") as! NSString
                self.gender.text = sex as String
                let userID : NSString = result.valueForKey("id") as! NSString
                let facebookProfileUrl = NSURL(string: "http://graph.facebook.com/\(userID)/picture?type=large")
                let userName : NSString = result.valueForKey("name") as! NSString
                self.name.text = userName as String
                if let data = NSData(contentsOfURL: facebookProfileUrl!) {
                    self.profilePic.image = UIImage(data: data)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        self.spinner.stopAnimating()
                        self.spinner.hidden = true
                    })
                }
            }
        })
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
