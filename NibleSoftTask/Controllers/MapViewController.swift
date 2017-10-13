//
//  MapViewController.swift
//  NibleSoftTask
//
//  Created by Egor Yanukovich on 10/11/17.
//  Copyright © 2017 Egor Yanukovich. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import RealmSwift

class MapViewController: UIViewController {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        tabBarItem = UITabBarItem(title: "Map", image: #imageLiteral(resourceName: "mapImage") , selectedImage: #imageLiteral(resourceName: "mapImage"))
    }
    
    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    var locationManager = CLLocationManager()
    lazy var geocoder = CLGeocoder()
    
    var weatherView = WeatherView()
    
    
    
    var realm : Realm!
    var weatherData = WeatherDataManager()
    var dailyWeather : Results<WeatherModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myMapView.delegate = self
        currentLocation()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }

    func currentLocation(){
        if (CLLocationManager.locationServicesEnabled()) {
            
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if let error = error {
            print("Unable to Reverse Geocode Location (\(error))")
            weatherData.address = "Name of place, Street, City, Country"
            
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                weatherData.address = placemark.compactAddress!
            } else {
                weatherData.address = "No Matching Addresses Found"
            }
        }
    }
    
    func loadDataWith(latitude : String, longitude: String){
        do {
            self.realm = try Realm()
            
        } catch {
            
        }
        
        self.weatherData.downloadWeatherDailyRealmWeather(latitude: latitude, longitude: longitude) { (success) in
            if success {
                print("success")
                self.dailyWeather = self.realm.objects(WeatherModel.self)
            }
        }
    }
    
}
//MARK: - CLLocationManagerDelegate
extension MapViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation : CLLocation = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        myMapView.setRegion(region, animated: true)
        
        let myAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        myMapView.addAnnotation(myAnnotation)
        
        let latitude = String(userLocation.coordinate.latitude)
        let longitude = String(userLocation.coordinate.longitude)
        
        loadDataWith(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(userLocation) { (placemark, error) in
            self.processResponse(withPlacemarks: placemark, error: error)
        }
        
        self.locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error \(error)")
    }
}
//MARK: - MKMapViewDelegate
extension MapViewController : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }
        else{
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        print("didSelect")
        let views = Bundle.main.loadNibNamed("WeatherView", owner: nil, options: nil)
        let calloutView = views?[0] as! WeatherView
        calloutView.latitudeLabel.text = dailyWeather?.last?.latitude
        calloutView.longitudeLabel.text = dailyWeather?.last?.longitude
        calloutView.addressLabel.text = dailyWeather?.last?.address
        
        calloutView.temperatureLabel.text = dailyWeather?.last?.temperature
        calloutView.weatherImage.image = UIImage(named: (dailyWeather?.last?.weatherImage)!)
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("Did deselect")
        for subview in view.subviews{
            
            subview.removeFromSuperview()
            
        }
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        myActivityIndicator.stopAnimating()
    }
}

extension CLPlacemark{
    
    var compactAddress: String? {
        if let name = name {
            var result = name
            print("1\(result)")
            if let street = thoroughfare{
                if street != name{
                    result += ",\(street)"
                }
                
            }
            if let city = locality {
                result += ", \(city)"
                print("3\(result)")
            }
            if let country = country{
                result += ", \(country)"
                print("4\(result)")
            }
            
            return result
        }
        return nil
    }
    
}




















