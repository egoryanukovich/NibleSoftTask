//
//  HistoryInfoController.swift
//  NibleSoftTask
//
//  Created by Egor Yanukovich on 10/13/17.
//  Copyright © 2017 Egor Yanukovich. All rights reserved.
//

import UIKit

class HistoryInfoController: UIViewController {

    @IBOutlet weak var longitudeInfoLabel: UILabel!
    @IBOutlet weak var latitudeInfoLabel: UILabel!
    
    @IBOutlet weak var placeInfoLabel: UILabel!
    
    @IBOutlet weak var temperatureInfoLabel: UILabel!
    
    @IBOutlet weak var weatherInfoImage: UIImageView!
    
    var weatherModelObject = WeatherModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 64))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem()
        
        let backItem = UIBarButtonItem(title: "Archive", style: .done, target: self, action: #selector(goBack(_:)))
        
        navItem.leftBarButtonItem = backItem
        navBar.setItems([navItem], animated: false)
       
    }
    override func viewDidAppear(_ animated: Bool) {
        latitudeInfoLabel.text = weatherModelObject.latitude
        longitudeInfoLabel.text = weatherModelObject.longitude
        placeInfoLabel.text = weatherModelObject.address
        
        temperatureInfoLabel.text = weatherModelObject.temperature
        weatherInfoImage.image = UIImage(named: weatherModelObject.weatherImage!)
        
    }
    @objc func goBack(_ sender: UIBarButtonItem){
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
