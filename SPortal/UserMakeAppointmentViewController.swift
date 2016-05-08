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
    @IBAction func clickConfirm(sender: UIButton) {
        if self.sportType == "Football" ||  self.sportType == "Basketball" || self.sportType == "Badminton" || self.sportType == "Tennis" || self.sportType == "BBGun" || self.sportType == "Baseball"{
            performSegueWithIdentifier("goGroup", sender: self)
        }else{
            performSegueWithIdentifier("goSingle", sender: self)
        }
    }
    var sportType:String = ""
    let locationManager = CLLocationManager()
    var locationtitle :String = "Didn't Selected"
    var lat : Double!
    var lon : Double!
    @IBOutlet var cancel: UIButton!
    @IBOutlet var confirm: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.map.delegate = self
        let SportComplex = MKPointAnnotation()
        SportComplex.coordinate.latitude = 13.73888
        SportComplex.coordinate.longitude = 100.52586
        SportComplex.title = "SportComplex"
        SportComplex.subtitle = "Sport complex at Chulalongkorn"
        let CU = MKPointAnnotation()
        CU.coordinate.latitude = 13.73650
        CU.coordinate.longitude = 100.52885
        CU.title = "Chulalongkorn"
        CU.subtitle = "University"
        let starclub = MKPointAnnotation()
        starclub.coordinate.latitude = 13.78390
        starclub.coordinate.longitude = 100.55357
        starclub.title = "Starclub"
        starclub.subtitle = "Football stadium"
        let predator = MKPointAnnotation()
        predator.coordinate.latitude = 13.835246
        predator.coordinate.longitude = 100.528851
        predator.title = "Predator"
        predator.subtitle = "BB gun arena"
        let f20 = MKPointAnnotation()
        f20.coordinate.latitude = 13.737384
        f20.coordinate.longitude = 100.59288
        f20.title = "F20Baseball"
        f20.subtitle = "Baseball Stadium"
        if self.sportType == "Football"{
            self.map.addAnnotation(starclub)
        }else if sportType == "Boxing" || sportType == "Yoga" || sportType == "Workout" || sportType == "Basketball" || sportType == "Badminton"{
            self.map.addAnnotation(SportComplex)
        }else if sportType == "BBGun"{
            
            self.map.addAnnotation(predator)
        }
        else if sportType == "Baseball"{
            self.map.addAnnotation(f20)
        }else if sportType == "Tennis"{
            self.map.addAnnotation(CU)
        }
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
        self.lat = ((view.annotation?.coordinate.latitude))
        self.lon = ((view.annotation?.coordinate.longitude))
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(self.sportType)
        if self.sportType == "Football" ||  self.sportType == "Basketball" || self.sportType == "Badminton" || self.sportType == "Tennis" || self.sportType == "BBGun" || self.sportType == "Baseball" {
            if let destination = segue.destinationViewController as? CreateGroupSportTableViewController {
                destination.fromSegue = self.locationtitle
                destination.sportType = self.sportType
                destination.latitude = self.lat
                destination.longitude = self.lon
                print("sadasd")
            }
        }else{
            if let destination = segue.destinationViewController as? UserCreateTableViewController {
                print("qweqw")
                destination.fromSegue = self.locationtitle
                destination.sportType = self.sportType
                destination.latitude = self.lat
                destination.longitude = self.lon
                
            }
        }
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) {
            annotationView.annotation = annotation
            return annotationView
        } else {
            let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
            annotationView.enabled = true
            annotationView.canShowCallout = true
            
            let btn = UIButton(type: .DetailDisclosure)
            annotationView.rightCalloutAccessoryView = btn
            return annotationView
        }
        
        return nil
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
