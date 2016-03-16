//
//  testViewController.swift
//  SPortal
//
//  Created by Tanakorn on 3/14/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit

class testViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let urlPath: String = "http://localhost/Project/test.json"
//        var url: NSURL = NSURL(string: urlPath)!
//        var request1: NSURLRequest = NSURLRequest(URL: url)
//        let queue:NSOperationQueue = NSOperationQueue()
//        NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
//            var err: NSError
//            do{
//            let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
//                print("AsSynchronous\(jsonResult)")
//            }catch{
//                
//            }
//            
//        })
//        
//        var err: NSError
// Do any additional setup after loading the view.
//        let postEndPoint: String = "http://requestb.in/t4puk4t4"
//        let url = NSURL(string: postEndPoint)!
//        let session = NSURLSession.sharedSession()
//        let postParams : [String:AnyObject] = ["hello":"Hello guys"]
//        let request = NSMutableURLRequest(URL: url)
//        request.HTTPMethod = "POST"
//        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        do{
//            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(postParams, options: NSJSONWritingOptions())
//            print(postParams)
//        }catch{
//            print("error cant post")
//        }
//        session.dataTaskWithRequest(request,completionHandler: {
//            (data:NSData?,response:NSURLResponse?,error: NSError?) -> Void in
//            guard let realResponse = response as? NSHTTPURLResponse where
//                realResponse.statusCode == 200 else{
//                    print("not 200")
//                    return
//            }
//            if let postString = NSString(data:data!,encoding:  NSUTF8StringEncoding) as? String {
//                print("POST:"+postString)
//            }
//        }).resume()
        let myUrl = NSURL(string: "http://192.168.43.138:3000/addEvent")
        let request = NSMutableURLRequest(URL:myUrl!)
        request.HTTPMethod = "POST"
        // Compose a query string
        let postString = "firstName=James&lastName=Bond"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("response = \(response)")
            
            // Print out response body
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            //Let’s convert response sent from a server side script to a NSDictionary object:
            
            var err: NSError?
            do{
            var myJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
            
            if let parseJSON = myJSON {
                // Now we can access value of First Name by its key
                var firstNameValue = parseJSON["firstName"] as? String
                print("firstNameValue: \(firstNameValue)")
            }
            }catch{
                
            }
            
        }
        
        task.resume()
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
