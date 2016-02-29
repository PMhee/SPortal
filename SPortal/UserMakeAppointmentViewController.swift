//
//  UserMakeAppointmentViewController.swift
//  SPortal
//
//  Created by Tanakorn on 1/23/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class UserMakeAppointmentViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    @IBOutlet weak var map: MKMapView!
    var sportType:String = ""
    let locationManager = CLLocationManager()
    var locationtitle :String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
        self.map.delegate = self
        let SportComplex = MKPointAnnotation()
        SportComplex.coordinate.latitude = 13.73888
        SportComplex.coordinate.longitude = 100.52586
        SportComplex.title = "CU SportComplex"
        SportComplex.subtitle = "Chulalongkorn Sport Complex"
        let CU = MKPointAnnotation()
        CU.coordinate.latitude = 14.73888
        CU.coordinate.longitude = 101.52586
        CU.title = "Chulalongkorn University"
        CU.subtitle = "The 1st University in thailand"
        self.map.addAnnotation(CU)
        self.map.addAnnotation(SportComplex)
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            self.map.showsUserLocation = true
            
        }
    }
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        self.locationtitle = ((view.annotation?.title)!)!
     
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? UserCreateTableViewController {
            if segue.identifier == "confirm"{
            destination.fromSegue = self.locationtitle
            destination.sportType = self.sportType
            print(self.locationtitle)
            }
        }
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
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        print(region)
        self.map.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func confirm(sender: UIButton) {
    }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
