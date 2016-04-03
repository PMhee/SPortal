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
class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        if(FBSDKAccessToken.currentAccessToken() == nil)
        {
            print("Not log in")
        }
        else{
            print("Log in")
        }
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile","user_friends"]
        loginButton.center = self.view.center
        loginButton.delegate = self
        self.view.addSubview(loginButton)
        returnUserData()
        
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
            }
        })
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("log out")
    }
}

