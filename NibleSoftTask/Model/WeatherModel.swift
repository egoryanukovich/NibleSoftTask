//
//  WeatherModel.swift
//  NibleSoftTask
//
//  Created by Egor Yanukovich on 10/12/17.
//  Copyright © 2017 Egor Yanukovich. All rights reserved.
//

import UIKit
import RealmSwift

class WeatherModel: Object {
    @objc dynamic var requestDate : Date?
    @objc dynamic var temperature : String?
    @objc dynamic var weatherImage: String?
    @objc dynamic var weatherDate: String?
    
    @objc dynamic var latitude: String?
    @objc dynamic var longitude: String?
    @objc dynamic var address: String?
    
    override class func primaryKey() ->String?{
        return "weatherDate"
    }

}
