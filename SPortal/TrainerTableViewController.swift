//
//  TrainerTableViewController.swift
//  SPortal
//
//  Created by Tanakorn on 1/25/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit

class TrainerTableViewController: UITableViewController {
    let imageArray = ["fitness icon","yoga icon","boxing icon","fitness icon","fitness icon","football icon"]
    var events = [DataToPass]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addEvents()
//        let urlPath: String = "http://localhost/Project/sportTable.json"
//        var url: NSURL = NSURL(string: urlPath)!
//        var request1: NSURLRequest = NSURLRequest(URL: url)
//        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse? >= nil
//        var error: NSErrorPointer = nil
//        do{
//            var dataVal: NSData =  try NSURLConnection.sendSynchronousRequest(request1, returningResponse: response)
//            var jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
//            print("Synchronous \(jsonResult)")
//            var a = jsonResult.valueForKey("events")!
//            for i in 0...a.count-1 {
//                events.append(DataToPass(type: a[i].valueForKey("type")! as! String,date: a[i].valueForKey("date")! as! String,time:  a[i].valueForKey("time")! as! String,place:  a[i].valueForKey("place")! as! String,author:  a[i].valueForKey("author")! as! String,price:  a[i].valueForKey("price")! as! String,image: a[i].valueForKey("image")! as! String,latitude: a[i].valueForKey("latitude")! as! String,longitude: a[i].valueForKey("longitude")! as! String,bg: a[i].valueForKey("bg")! as! String,attendant: a[i].valueForKey("attendant")! as! String,max: a[i].valueForKey("max")! as! String))
//            }
//        }catch{
//            
//        }
//        var err: NSError
//        print(response)
    }
    func addEvents(){
        let event1 = DataToPass(type:"Boxing",date:"March 12, 2016",time:"10:40",place:"Chulalongkorn University",author:"Tanakorn",price:"500",image:"boxing icon",latitude: "13.73888",longitude: "100.52586",bg: "boxing bg",attendant: "3",max:"5",pic:"profilePic")
        let event2 = DataToPass(type:"Football",date:"March 13, 2016",time:"12:00",place:"Chulalongkorn University",author:"JJamie",price:"120",image:"football icon",latitude: "13.73888",longitude: "100.52586",bg: "football bg",attendant: "7",max:"10",pic:"jjamie")
        let event3 = DataToPass(type:"Workout",date:"March 14, 2016",time:"11:30",place:"Chulalongkorn University",author:"Chantawat",price:"700",image:"workout icon",latitude: "13.73888",longitude: "100.52586",bg: "workout bg",attendant: "2",max:"5",pic:"off")
        let event4 = DataToPass(type:"yoga",date:"March 15, 2016",time:"10:30",place:"Chulalongkorn University",author:"Kittinun ",price:"300",image:"yoga icon",latitude: "13.73888",longitude: "100.52586",bg: "yoga bg",attendant: "2",max:"5",pic:"best")
        events += [event1,event2,event3,event4]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if (segue.identifier == "pass") {
            
            // initialize new view controller and cast it as your view controller
            let des = segue.destinationViewController as? ShowEventViewController
            // your new view controller should have property that will store passed value
            var indexPath = self.tableView.indexPathForSelectedRow!
            var dataToPass = events[indexPath.row]
            des?.showEvent = dataToPass
        }
        
    }
    // MARK: - Table view data source
    override  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(named: events[indexPath.row].image)
        let author = cell.viewWithTag(2) as! UILabel
        author.text = events[indexPath.row].author
        let place = cell.viewWithTag(3) as! UILabel
        place.text = events[indexPath.row].place
        let price = cell.viewWithTag(4) as! UILabel
        price.text = events[indexPath.row].price + " ฿"
        var date = cell.viewWithTag(5) as! UILabel
        date.text = events[indexPath.row].date
        let type = cell.viewWithTag(6) as! UILabel
        type.text = events[indexPath.row].type
        let time = cell.viewWithTag(7) as! UILabel
        time.text = String(events[indexPath.row].time)
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
}
