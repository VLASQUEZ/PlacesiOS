//
//  MapViewController.swift
//  Places
//
//  Created by Andres Velasquez on 9/12/17.
//  Copyright © 2017 Andres Velasquez. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class MapViewController: UIViewController  {
    var place : Place!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegamos el objeto mapview a nuestra clase, por que vamos a administrar el control
        self.mapView.delegate = self
        self.mapView.showsScale = true
        self.mapView.showsCompass = true
        self.mapView.showsPointsOfInterest = true
        self.mapView.showsTraffic = true
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(place.location) {[unowned self] (placemarks, error) in
            if error == nil {
                for placemark in placemarks!{
                   let annotation = MKPointAnnotation()
                    annotation.title = self.place.name
                    annotation.coordinate = (placemark.location?.coordinate)!
                    annotation.subtitle = self.place.type
                    
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
            else{
                print ("ocurrió un error \(String(describing: error?.localizedDescription))")
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPinch"
        if annotation.isKind(of: MKUserLocation.self){
            return nil
        }
        var annotationView : MKPinAnnotationView? = self.mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 52, height: 52))
        imageView.image = self.place.image
        annotationView?.leftCalloutAccessoryView = imageView
        annotationView?.pinTintColor = UIColor.green
        return annotationView
        
    }
}
