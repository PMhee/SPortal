//
//  ShowEventViewController.swift
//  SPortal
//
//  Created by Tanakorn on 2/27/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import MapKit
class ShowEventViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate,UIScrollViewDelegate  {
    
    @IBOutlet weak var viewPlayer: UIButton!
    @IBOutlet weak var views: UIButton!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var join: UIButton!
    @IBOutlet weak var attend: UILabel!
    @IBOutlet weak var users: UIImageView!
    @IBOutlet weak var place: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var profilePic: UIImageView!
    let imageArray = ["weight bg","football bg","yoga bg","boxing bg"]
    let locationManager = CLLocationManager()
    var showEvent:DataToPass!
    override func viewDidLoad() {
        super.viewDidLoad()
        scroll.delegate = self
        join.layer.cornerRadius = 5
        join.setTitle("JOIN (\(showEvent.price) THB)", forState: .Normal)
        background.image = UIImage(named: showEvent.bg)!//.applyBlurWithRadius(3, tintColor: UIColor(white: 0.5, alpha: 0.7), saturationDeltaFactor: 1.8)
        profilePic.image = UIImage(named: showEvent.pic)
        profilePic.layer.masksToBounds = false
        profilePic.layer.cornerRadius = profilePic.frame.height/2
        profilePic.clipsToBounds = true
        self.attend.text = showEvent.attendant+"/"+showEvent.max
//        var max :Int = Int(showEvent.max)!
//        var att :Int = Int(showEvent.attendant)!
//        if max - att == 0 {
//            let join = users as UIImageView
//            join.image = UIImage(named: "social red")
//            
//        }else if 100-((max-att)*100/max) >= 70 {
//            let join = users as UIImageView
//            join.image = UIImage(named: "social orange")
//        }else if 100-((max-att)*100/max) >= 30 {
//            let join = users as UIImageView
//            join.image = UIImage(named: "social yellow")
//        }else{
//            let join = users as UIImageView
//            join.image = UIImage(named: "social green")
//        }
        map.layer.cornerRadius = 20
        self.name.text = showEvent.author
        self.place.setTitle(showEvent.place, forState: .Normal)
        //self.price.text = showEvent.price
        self.date.text = "Date: "+showEvent.date+" Time: "+showEvent.time
        self.type.text = showEvent.type.uppercaseString
        //image.image = UIImage(named: showEvent.image)
        // Do any additional setup after loading the view.
        let spot = MKPointAnnotation()
        spot.coordinate.latitude = Double(showEvent.latitude)!
        spot.coordinate.longitude = Double(showEvent.longitude)!
        self.map.addAnnotation(spot)
        locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
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
