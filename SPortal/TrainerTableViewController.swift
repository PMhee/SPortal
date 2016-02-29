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
        events = [DataToPass(type: "Workout ", date: "12/01/2016", time: "13.00-14.00", place: "SportComplex ",author: "Tanakorn Rattanajariya",price: "500-600 B",image : "fitness icon"),DataToPass(type: "Yoga ", date: "13/01/2016", time: "13.30-14.30", place: "AmornFitness ",author: "Tanakorn Rattanajariya",price: "800-1,000 B",image : "yoga icon"),DataToPass(type: "Kickboxing ", date: "13/01/2016", time: "9.00-10.00", place: "HouseFitness ",author: "Kirk Lertritpuwadol",price: "900-1,200 B",image : "boxing icon"),DataToPass(type: "Workout ", date: "12/01/2016", time: "10.00-11.00", place: "SportComplex ",author: "Kirk Lertritpuwadol",price: "500-600 B",image : "fitness icon"),DataToPass(type: "Workout ", date: "12/01/2016", time: "11.00-12.00", place: "SportComplex ",author: "Tanakorn Rattanajariya",price: "500-600 B",image : "fitness icon"),DataToPass(type: "football ", date: "12/01/2016", time: "8.00-9.00", place: "SportComplex ",author: "Kirk Lertritpuwadol",price: "500-600 B",image: "football icon")]
        
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
        price.text = events[indexPath.row].price
        let date = cell.viewWithTag(5) as! UILabel
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
