//
//  ViewController.swift
//  MapKit Lab
//
//  Created by Pursuit on 2/24/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    private let location = CoreLocationSession()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textField: UITextField!
    
    private var userTrackingButton: MKUserTrackingButton!
    
    private var isShowingAnnoations = false
    
    private var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        
        userTrackingButton = MKUserTrackingButton(frame: CGRect(x: 20, y: 20, width: 40, height: 40))
        mapView.addSubview(userTrackingButton)
        userTrackingButton.mapView = mapView

        // the actions under map view. 
        mapView.delegate = self
    }
    
    private func makeAnnotations() -> [MKPointAnnotation] {
        var annotationsInSideOfFunction = [MKPointAnnotation]()
        
        for school in SchoolAPIClient.getSchoolData(){
            guard let latitude: Double = school.latitude, let longitude: Double = school.longitude else {
                print("please lookl at makeAnnotations  functions")
            }
            let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let annotation = MKPointAnnotation()
            annotation.title = school.schoolName
           annotation.coordinate = coordinates
            annotationsInSideOfFunction.append(annotation)
        }
        isShowingAnnoations = true
        self.annotations = annotationsInSideOfFunction
        return annotationsInSideOfFunction
    }


}

extension MapViewController: MKMapViewDelegate{
    
    
    
}

