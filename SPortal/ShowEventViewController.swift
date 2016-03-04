//
//  ShowEventViewController.swift
//  SPortal
//
//  Created by Tanakorn on 2/27/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import MapKit
class ShowEventViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var place: UIButton!
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var map: MKMapView!
    var blur :String = ""
    @IBAction func clickName(sender: UIButton) {
    }
    let imageArray = ["weight bg","football bg","yoga bg","boxing bg"]
    let locationManager = CLLocationManager()
    var showEvent:DataToPass!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(showEvent.type)
        switch showEvent.type {
        case "Football" : self.blur = "football bg"
        case "BodyBuilding" : self.blur = imageArray[0]
        case "Yoga" : self.blur = imageArray[2]
        case "Boxing" : self.blur = imageArray[3]
        default : self.blur = ""
        }
        print("blur "+self.blur)
        background.image = UIImage(named: blur)!.applyBlurWithRadius(3, tintColor: UIColor(white: 0.5, alpha: 0.4), saturationDeltaFactor: 1.8)
        profilePic.image = UIImage(named: "profilePic")
        self.name.text = showEvent.author
        self.place.setTitle(showEvent.place, forState: .Normal)
        //self.price.text = showEvent.price
        self.date.text = showEvent.date
        self.type.text = showEvent.type
        self.time.text = showEvent.time
        //image.image = UIImage(named: showEvent.image)
        // Do any additional setup after loading the view.
        let spot = MKPointAnnotation()
        spot.coordinate.latitude = 13.73888
        spot.coordinate.longitude = 100.52586
        self.map.addAnnotation(spot)
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
        //self.locationManager.stopUpdatingLocation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        var view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
        } else {
            // 3
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }
        return view
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
