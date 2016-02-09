//
//  FitnessTableViewController.swift
//  SPortal
//
//  Created by Tanakorn on 1/24/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit

class FitnessTableViewController: UITableViewController {
    struct event {
        var type : String
        var date : String
        var time : String
        var place : String
        var author : String
        var price : String
    }
    var imageArray = ["dumbbell-512","c","32224354-boxing-gloves-flat-icon-with-long-shadow-Stock-Vector","dumbbell-512","dumbbell-512","dumbbell-512"]
    var events = [event(type: "Workout ", date: "12/01/2016", time: "13.00-14.00", place: "SportComplex ",author: "Tanakorn Rattanajariya",price: "500-600 B"),event(type: "Yoga ", date: "13/01/2016", time: "13.30-14.30", place: "AmornFitness ",author: "Tanakorn Rattanajariya",price: "800-1,000 B"),event(type: "Kickboxing ", date: "13/01/2016", time: "9.00-10.00", place: "HouseFitness ",author: "Kirk Lertritpuwadol",price: "900-1,200 B"),event(type: "Workout ", date: "12/01/2016", time: "10.00-11.00", place: "SportComplex ",author: "Kirk Lertritpuwadol",price: "500-600 B"),event(type: "Workout ", date: "12/01/2016", time: "11.00-12.00", place: "SportComplex ",author: "Tanakorn Rattanajariya",price: "500-600 B"),event(type: "Weighting ", date: "12/01/2016", time: "8.00-9.00", place: "SportComplex ",author: "Kirk Lertritpuwadol",price: "500-600 B"),]
    override func viewDidLoad() {
        super.viewDidLoad()
        var images : UIImageView
        imageArray.append("32224354-boxing-gloves-flat-icon-with-long-shadow-Stock-Vector")
        events.append(event(type: "Boxing", date: "22/01/2016", time: "10.00-11.00", place: "CU SportComplex", author: "PMhee", price: "200-300"))
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(named: imageArray[indexPath.row])
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