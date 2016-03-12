//
//  ShowNewsfeedViewController.swift
//  SPortal
//
//  Created by Tanakorn on 3/12/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit

class ShowNewsfeedViewController: UIViewController {
    @IBAction func clickInformation(sender: UIButton) {
        if let requestUrl = NSURL(string: "http://www.gotorace.com/event/tri-dash-bangkok-2016-jan/") {
            UIApplication.sharedApplication().openURL(requestUrl)
        }
    }
    @IBOutlet var information: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        information.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
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
