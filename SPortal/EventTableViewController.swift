//
//  TrainerTableViewController.swift
//  SPortal
//
//  Created by Tanakorn on 1/25/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    let imageArray = ["fitness icon","yoga icon","boxing icon","fitness icon","fitness icon","football icon"]
    var events = [DataToPass]()
    var searchResult = [DataToPass]()
    var selectedCellIndexPath: NSIndexPath?
    @IBOutlet weak var myTable: UITableView!
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
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("Search Button tapped")
        searchResult.removeLast()
    }
    func addEvents(){
        let event1 = DataToPass(type:"Boxing",date:"March 12, 2016",time:"10:40",place:"Chulalongkorn University",author:"Tanakorn Rattanajariya",price:"500",image:"boxing icon",latitude: "13.73888",longitude: "100.52586",bg: "boxing bg",attendant: "1",max:"5",pic:"profilePic")
        let event2 = DataToPass(type:"Football",date:"March 13, 2016",time:"12:00",place:"Chulalongkorn University",author:"JJamie Ratchata",price:"120",image:"football icon",latitude: "13.73888",longitude: "100.52586",bg: "football bg",attendant: "7",max:"10",pic:"jjamie")
        let event3 = DataToPass(type:"Workout",date:"March 14, 2016",time:"11:30",place:"Chulalongkorn University",author:"Chantawat Rattana",price:"700",image:"workout icon",latitude: "13.73888",longitude: "100.52586",bg: "workout bg",attendant: "5",max:"5",pic:"off")
        let event4 = DataToPass(type:"yoga",date:"March 15, 2016",time:"10:30",place:"Chulalongkorn University",author:"Kittinun Kaewtae",price:"300",image:"yoga icon",latitude: "13.73888",longitude: "100.52586",bg: "yoga bg",attendant: "3",max:"5",pic:"best")
        events += [event1,event2,event3,event4]
        searchResult = events
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
//        if let imageView = cell.viewWithTag(1) as? UIImageView{
//        imageView.image = UIImage(named: searchResult[indexPath.row].bg)!.applyBlurWithRadius(3, tintColor: UIColor(white: 0.5, alpha: 0.4), saturationDeltaFactor: 1.8)
//        }
        if let author = cell.viewWithTag(2) as? UILabel{
        author.text = searchResult[indexPath.row].author
        }
        if let place = cell.viewWithTag(3) as? UILabel{
        place.text = searchResult[indexPath.row].place
        }
        if let price = cell.viewWithTag(4) as? UILabel{
        price.text = searchResult[indexPath.row].price + " THB"
        }
        if let date = cell.viewWithTag(5) as? UILabel{
        date.text = searchResult[indexPath.row].date
        }
        let attend = cell.viewWithTag(6) as! UILabel
        attend.text = searchResult[indexPath.row].attendant + "/" + searchResult[indexPath.row].max
        var max :Int = Int(searchResult[indexPath.row].max)!
        var att :Int = Int(searchResult[indexPath.row].attendant)!
        if max - att == 0 {
            let join = cell.viewWithTag(10) as! UIImageView
            join.image = UIImage(named: "social red")
        }else if 100-((max-att)*100/max) >= 70 {
            let join = cell.viewWithTag(10) as! UIImageView
            join.image = UIImage(named: "social orange")
        }else if 100-((max-att)*100/max) >= 30 {
            let join = cell.viewWithTag(10) as! UIImageView
            join.image = UIImage(named: "social yellow")
        }else{
            let join = cell.viewWithTag(10) as! UIImageView
            join.image = UIImage(named: "social green")
        }
        if let time = cell.viewWithTag(7) as? UILabel{
            time.text = String(searchResult[indexPath.row].time)
        }
        if let icon = cell.viewWithTag(8) as? UIImageView{
            icon.image = UIImage(named: searchResult[indexPath.row].image)
        }
        if let type = cell.viewWithTag(9) as? UILabel{
            type.text = String(searchResult[indexPath.row].type).uppercaseString
        }
        let views = cell.viewWithTag(11) as UIView!
        views.layer.cornerRadius = 5
        
//        let back :UIView = UIView(frame: cell.frame)
//        back.backgroundColor = UIColor(colorLiteralRed:171, green: 171, blue: 171, alpha: 1)
//        cell.selectedBackgroundView = back
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
}
