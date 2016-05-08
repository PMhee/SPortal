//
//  ViewController.swift
//  SPortal
//
//  Created by Tanakorn on 1/7/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import CoreData
import Alamofire
class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet var login: FBSDKLoginButton!
    @IBOutlet weak var logo: UIImageView!
    var friends = [Friend]()
    var key:String!
    var user_id: String!
    var user_name: String!
    struct Achievement {
        var title : String
        var date : String
        var checked : String
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.logo.layer.cornerRadius = 10
        Alamofire.request(.GET, "http://localhost:3000/requestCsrf")
            .responseString { response in
                print("Response String: \(response.result.value)")
                self.key = String(response.result.value!)
                print(self.key)
                
        }
        if(FBSDKAccessToken.currentAccessToken() == nil)
        {
            print("Not log in")
        }
        else{
            print("Log in")
        }
        login.readPermissions = ["public_profile","user_friends"]
        login.delegate = self
        
        
    }
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if error == nil
        {
            print("login complete")
            self.performSegueWithIdentifier("goInfo", sender: self)
        }
        else
        {
            print(error.localizedDescription)
        }
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("log out")
    }
}

