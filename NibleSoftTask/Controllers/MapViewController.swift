//
//  MapViewController.swift
//  NibleSoftTask
//
//  Created by Egor Yanukovich on 10/11/17.
//  Copyright © 2017 Egor Yanukovich. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        tabBarItem = UITabBarItem(title: "Map", image: #imageLiteral(resourceName: "mapImage") , selectedImage: #imageLiteral(resourceName: "mapImage"))
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        myMapView.delegate = self
    }


}


extension MapViewController : MKMapViewDelegate{
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        myActivityIndicator.stopAnimating()
    }
}
