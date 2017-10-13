//
//  WeatherView.swift
//  NibleSoftTask
//
//  Created by Egor Yanukovich on 10/11/17.
//  Copyright © 2017 Egor Yanukovich. All rights reserved.
//

import UIKit

class WeatherView: UIView {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup()  {
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
    }
}
