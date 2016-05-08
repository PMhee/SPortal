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
import Charts
class StatViewController: UIViewController,UIScrollViewDelegate {
    
    
    @IBOutlet weak var sport5_type: UILabel!
    @IBOutlet weak var sport4_type: UILabel!
    @IBOutlet weak var sport3_type: UILabel!
    @IBOutlet weak var sport2_type: UILabel!
    @IBOutlet weak var sport1_type: UILabel!
    @IBOutlet weak var fav_type: UILabel!
    @IBOutlet weak var fav_icon: UIImageView!
    @IBOutlet weak var playHour: UILabel!
    @IBOutlet weak var sport5_time: UILabel!
    @IBOutlet weak var sport4_time: UILabel!
    @IBOutlet weak var sport3_time: UILabel!
    @IBOutlet weak var sport2_time: UILabel!
    @IBOutlet weak var sport1_time: UILabel!
    @IBOutlet weak var sport5_icon: UIImageView!
    @IBOutlet weak var sport4_icon: UIImageView!
    @IBOutlet weak var sport3_icon: UIImageView!
    @IBOutlet weak var sport2_icon: UIImageView!
    @IBOutlet weak var sport1_icon: UIImageView!
    @IBOutlet weak var sport5: UIView!
    @IBOutlet weak var sport4: UIView!
    @IBOutlet weak var sport3: UIView!
    @IBOutlet weak var sport1: UIView!
    @IBOutlet weak var sport2: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pieChart: PieChartView!
    var user = [User]()
    var user_id : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        self.getProfile()
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        print(scrollView.contentOffset.y + scrollView.contentOffset.x)
        //        if (scrollView.contentOffset.y != 0) {
        //            var offset:CGPoint = scrollView.contentOffset
        //            offset.y = 0
        //            scrollView.contentOffset = offset
        //        }
        if (scrollView.contentOffset.x != 0) {
            var offset:CGPoint = scrollView.contentOffset
            offset.x = 0
            scrollView.contentOffset = offset        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getProfile(){
        self.user = [User]()
        let urlPath: String = "http://localhost:3000/getProfile/"+self.user_id
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
            //                            print(jsonResult.valueForKey("facebookId")! as! String)
            //                            print(jsonResult.valueForKey("displayName")! as! String)
            //                            print(firstName.substringWithRange(Range<String.Index>(start: firstName.startIndex.advancedBy(0), end: firstName.startIndex.advancedBy(index))))
            //                            print(jsonResult.valueForKey("achievement")! as! NSArray)
            //                            print(jsonResult.valueForKey("notification")! as! NSArray)
            //                            print(jsonResult.valueForKey("friends")! as! NSArray)
            //                            print(jsonResult.valueForKey("favorite")! as! NSArray)
            let data :User = User(UserID:jsonResult.valueForKey("facebookId") as? String,Username:jsonResult.valueForKey("displayName") as? String,profilePic:firstName.substringWithRange(Range<String.Index>(start: firstName.startIndex.advancedBy(0), end: firstName.startIndex.advancedBy(index))),achievement:jsonResult.valueForKey("achievement") as? NSArray,notification:jsonResult.valueForKey("notification") as? NSArray,friends:jsonResult.valueForKey("friends") as? NSArray,favourite:jsonResult.valueForKey("favorite") as? NSArray,About:jsonResult.valueForKey("about") as! String,newNotification:jsonResult.valueForKey("newNotification") as? NSArray,receipt:jsonResult.valueForKey("receipt") as? NSArray,stat:jsonResult.valueForKey("stat") as? NSArray,newFeed:jsonResult.valueForKey("newFeed") as? NSArray)
            print(data)
            self.user.append(data)
            var sports = [String]()
            var spend = [Double]()
            if self.user[0].stat != nil{
            if self.user[0].stat.count >= 1{
            for i in 0...self.user[0].stat.count-1 {
                sports.append(self.user[0].stat[i].valueForKey("sport") as! String)
                spend.append((self.user[0].stat[i].valueForKey("hour") as! Double))
            }
            setChart(sports, values: spend)
                if sports.count == 1{
                    sport1.layer.cornerRadius = 5
                    if Int(spend[0]) > 1 {
                        sport1_time.text = String(Int(spend[0]))+" HOURS"
                    }else{
                        sport1_time.text = String(Int(spend[0]))+" HOUR"
                    }
                    sport1_type.text = sports[0]
                    sport1_icon.image = UIImage(named: sports[0] + " icon")
                }else if sports.count == 2{
                    sport1.layer.cornerRadius = 5
                    sport2.layer.cornerRadius = 5
                    sport1_type.text = sports[0]
                    sport2_type.text = sports[1]
                    if Int(spend[0]) > 1 {
                        sport1_time.text = String(Int(spend[0]))+" HOURS"
                    }else{
                        sport1_time.text = String(Int(spend[0]))+" HOUR"
                    }
                    if Int(spend[1]) > 1 {
                        sport2_time.text = String(Int(spend[1]))+" HOURS"
                    }else{
                        sport2_time.text = String(Int(spend[1]))+" HOUR"
                    }
                    sport1_icon.image = UIImage(named: sports[0] + " icon")
                    sport2_icon.image = UIImage(named: sports[1] + " icon")
                }else if sports.count == 3{
                    sport1.layer.cornerRadius = 5
                    sport2.layer.cornerRadius = 5
                    sport3.layer.cornerRadius = 5
                    sport1_type.text = sports[0]
                    sport2_type.text = sports[1]
                    sport3_type.text = sports[2]

                    if Int(spend[0]) > 1 {
                        sport1_time.text = String(Int(spend[0]))+" HOURS"
                    }else{
                        sport1_time.text = String(Int(spend[0]))+" HOUR"
                    }
                    if Int(spend[1]) > 1 {
                        sport2_time.text = String(Int(spend[1]))+" HOURS"
                    }else{
                        sport2_time.text = String(Int(spend[1]))+" HOUR"
                    }
                    if Int(spend[2]) > 1 {
                        sport3_time.text = String(Int(spend[2]))+" HOURS"
                    }else{
                        sport3_time.text = String(Int(spend[2]))+" HOUR"
                    }
                    sport1_icon.image = UIImage(named: sports[0] + " icon")
                    sport2_icon.image = UIImage(named: sports[1] + " icon")
                    sport3_icon.image = UIImage(named: sports[2] + " icon")
                }else if sports.count == 4{
                    sport1.layer.cornerRadius = 5
                    sport2.layer.cornerRadius = 5
                    sport3.layer.cornerRadius = 5
                    sport4.layer.cornerRadius = 5
                    sport1_type.text = sports[0]
                    sport2_type.text = sports[1]
                    sport3_type.text = sports[2]
                    sport4_type.text = sports[3]
                    if Int(spend[0]) > 1 {
                        sport1_time.text = String(Int(spend[0]))+" HOURS"
                    }else{
                        sport1_time.text = String(Int(spend[0]))+" HOUR"
                    }
                    if Int(spend[1]) > 1 {
                        sport2_time.text = String(Int(spend[1]))+" HOURS"
                    }else{
                        sport2_time.text = String(Int(spend[1]))+" HOUR"
                    }
                    if Int(spend[2]) > 1 {
                        sport3_time.text = String(Int(spend[2]))+" HOURS"
                    }else{
                        sport3_time.text = String(Int(spend[2]))+" HOUR"
                    }
                    if Int(spend[3]) > 1 {
                        sport4_time.text = String(Int(spend[3]))+" HOURS"
                    }else{
                        sport4_time.text = String(Int(spend[3]))+" HOUR"
                    }
                    sport1_icon.image = UIImage(named: sports[0] + " icon")
                    sport2_icon.image = UIImage(named: sports[1] + " icon")
                    sport3_icon.image = UIImage(named: sports[2] + " icon")
                    sport4_icon.image = UIImage(named: sports[3] + " icon")

                }else if sports.count == 5{
                    sport1.layer.cornerRadius = 5
                    sport2.layer.cornerRadius = 5
                    sport3.layer.cornerRadius = 5
                    sport4.layer.cornerRadius = 5
                    sport5.layer.cornerRadius = 5
                    sport1_type.text = sports[0]
                    sport2_type.text = sports[1]
                    sport3_type.text = sports[2]
                    sport4_type.text = sports[3]
                    sport5_type.text = sports[4]
                    
                    if Int(spend[0]) > 1 {
                        sport1_time.text = String(Int(spend[0]))+" HOURS"
                    }else{
                        sport1_time.text = String(Int(spend[0]))+" HOUR"
                    }
                    if Int(spend[1]) > 1 {
                        sport2_time.text = String(Int(spend[1]))+" HOURS"
                    }else{
                        sport2_time.text = String(Int(spend[1]))+" HOUR"
                    }
                    if Int(spend[2]) > 1 {
                        sport3_time.text = String(Int(spend[2]))+" HOURS"
                    }else{
                        sport3_time.text = String(Int(spend[2]))+" HOUR"
                    }
                    if Int(spend[3]) > 1 {
                        sport4_time.text = String(Int(spend[3]))+" HOURS"
                    }else{
                        sport4_time.text = String(Int(spend[3]))+" HOUR"
                    }
                    if Int(spend[4]) > 1 {
                        sport5_time.text = String(Int(spend[4]))+" HOURS"
                    }else{
                        sport5_time.text = String(Int(spend[4]))+" HOUR"
                    }
                    sport1_icon.image = UIImage(named: sports[0] + " icon")
                    sport2_icon.image = UIImage(named: sports[1] + " icon")
                    sport3_icon.image = UIImage(named: sports[2] + " icon")
                    sport4_icon.image = UIImage(named: sports[3] + " icon")
                    sport5_icon.image = UIImage(named: sports[4] + " icon")
                }else{
                    
                }
            
            var max = 0
            var find = 0
            for i in 0...user[0].stat.count-1{
                if user[0].stat[i].valueForKey("commented") as! Int > max {
                    max = user[0].stat[i].valueForKey("commented") as! Int
                    find = i
                }
            }
                if max == 0{
                    
                }else{
            self.fav_icon.image = UIImage(named: (user[0].stat[find].valueForKey("sport") as! String)+" icon")
            self.fav_type.text = user[0].stat[find].valueForKey("sport") as! String
            
                }
                var sum = 0.0
                for i in 0...user[0].stat.count-1{
                    sum += user[0].stat[i].valueForKey("hour") as! Double
                }
                let d = NSDate()
                print(d)
                print(String(d).substringWithRange(Range<String.Index>(start: (String(d).startIndex.advancedBy(5)), end: String(d).startIndex.advancedBy(7))))
                
                self.playHour.text = String(sum/Double(String(d).substringWithRange(Range<String.Index>(start: (String(d).startIndex.advancedBy(5)), end: String(d).startIndex.advancedBy(7))))!)
            }
            }
        }catch{
        }
        var err: NSError
        print(response)
        
    }

    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChart.data = pieChartData
        
        var colors: [UIColor] = []
        let color1 = UIColor(red: 173/255, green: 0/255, blue: 0/255, alpha: 1)
        colors.append(color1)
        let color2 = UIColor(red: 214/255, green: 137/255, blue: 16/255, alpha: 1)
        colors.append(color2)
        let color3 = UIColor(red: 51/255, green: 62/255, blue: 90/255, alpha: 1)
        colors.append(color3)
        let color4 = UIColor(red: 84/255, green: 110/255, blue: 122/255, alpha: 1)
        colors.append(color4)
        let color5 = UIColor(red: 159/255, green: 208/255, blue: 187/255, alpha: 1)
        colors.append(color5)
        
        pieChartDataSet.colors = colors
        self.sport1.backgroundColor = color1
        self.sport2.backgroundColor = color2
        self.sport3.backgroundColor = color3
        self.sport4.backgroundColor = color4
        self.sport5.backgroundColor = color5
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
