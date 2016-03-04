//
//  ShowEventViewController.swift
//  SPortal
//
//  Created by Tanakorn on 2/27/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import MapKit
class ShowEventViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    @IBAction func clickName(sender: UIButton) {
    }
    let locationManager = CLLocationManager()
    var showEvent:DataToPass!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.name.setTitle(showEvent.author, forState: .Normal)
        //self.place.setTitle(showEvent.place, forState: .Normal)
        //self.price.text = showEvent.price
        //self.date.text = showEvent.date
        //self.type.text = showEvent.type
        //self.time.text = showEvent.time
        //image.image = UIImage(named: showEvent.image)
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: Double(showEvent.latitude)!, longitude: Double(showEvent.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        print(region)
        self.map.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
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
