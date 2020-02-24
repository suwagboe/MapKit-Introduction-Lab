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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        mapView.delegate = self
        
    }


}

extension MapViewController: MKMapViewDelegate{
    
    
    
}

