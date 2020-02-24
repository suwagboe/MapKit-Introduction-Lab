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

    private let locationSession = CoreLocationSession()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textField: UITextField!
    
    private var userTrackingButton: MKUserTrackingButton!
    
    private var isShowingAnnoations = false
    
    private var annotations = [MKPointAnnotation]()
    
    private var schools = [SchoolData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        
        userTrackingButton = MKUserTrackingButton(frame: CGRect(x: 20, y: 20, width: 40, height: 40))
        mapView.addSubview(userTrackingButton)
        userTrackingButton.mapView = mapView

        // the actions under map view. 
        mapView.delegate = self
        loadMap()
        getTheData()
    }
    
    private func getTheData() {
        SchoolAPIClient.getSchoolLocations() { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let schoolss):
                self?.schools = schoolss
                DispatchQueue.main.async {
                    self?.loadMap()
                }
            }
        }
    }
    
    private func loadMap() {
        let annotations = makeAnnotations()

        mapView.addAnnotations(annotations)
    }
    
    private func makeAnnotations() -> [MKPointAnnotation] {
        var annotationsInSideOfFunction = [MKPointAnnotation]()
        
        for school in schools {
            guard let latitude = Double(school.latitude), let longitude = Double(school.longitude) else {
                print("please lookl at makeAnnotations  functions")
                return annotationsInSideOfFunction
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
    
    private func convertPlaceNameToCoordinate(_ placeName: String){
        locationSession.convertPlaceNameToCoordinate(addressString: placeName) { (result) in
            switch result {
            case .failure(let error):
                print("geocoding error: \(error)")
            case .success(let coordinate):
                print("coordinate: \(coordinate)")
                // set map viee at given coordinate
                
                // this is the range... region that it should measure...
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000 , longitudinalMeters: 5000)
                // this will animate/move map to the given coordinates while maintain the radius that was given above
                self.mapView.setRegion(region, animated: true)
            }
            
        }
    }

}

extension MapViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // want to guard against it being the users current location
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "annotationView"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView // the marker has more properties then the pin
        // This one is calling the annotations from above the view did load...
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.glyphImage = UIImage(named: "duck")
            annotationView?.glyphTintColor = .blue
            annotationView?.markerTintColor = .systemTeal
          //  annotationView?.glyphText = "Boo"
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print("finished loading")
        if isShowingAnnoations {
            // we set it to false because to allows for a better zoom annotation
            mapView.showAnnotations(annotations, animated: false)
        }
        // set it to false so it doesnt automatically show the animation again

        isShowingAnnoations = false
    }
    
}

