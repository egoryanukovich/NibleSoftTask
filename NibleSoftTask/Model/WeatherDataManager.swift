//
//  WeatherDataManager.swift
//  NibleSoftTask
//
//  Created by Egor Yanukovich on 10/12/17.
//  Copyright © 2017 Egor Yanukovich. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire

class WeatherDataManager {
    
    var address = "Name of place, Street, City, Country"
    var dateOfRequest : Date?
    
    private var _temperature : Float?
    private var _date : Double?
    private var _icon : String?
    
    var icon : String{
        return _icon ?? "Invalid icon"
    }
    
    var date : Double{
        return _date ?? 0.0
    }
    
    var temperature : Float{
        return _temperature ?? 0
    }
    
    var realm = try! Realm()
    
    func downloadWeatherDailyRealmWeather(latitude : String, longitude : String, completed : @escaping(Bool) -> Void){
        let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&mode=json&appid=5dbd6e93d8ceeada8a687e06be362fc1")!
        dateOfRequest = Date()
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            
            self.dateOfRequest = Date()
            if let result = response.result.value as? [String:Any]{
                print(result)
                if let forecastDate = result["dt"] as? Double{
                    self._date = forecastDate
                }
                
                if let mainArray = result["main"] as? [String :Any] {
                    self._temperature = mainArray["temp"] as? Float
                }
                
                if let weatherArray = result["weather"] as? [[String:Any]]{
                    for element in weatherArray {
                        self._icon = element["icon"] as? String
                    }
                }
                let weatherObject = WeatherModel()
                
                weatherObject.address = self.address
                weatherObject.latitude = latitude
                weatherObject.longitude = longitude
                weatherObject.requestDate = self.dateOfRequest
                weatherObject.temperature = String(format:"%.0f °C", self._temperature! - 273.15)
                weatherObject.weatherDate = String(describing: self._date!)
                weatherObject.weatherImage = self._icon!
                
                print(weatherObject)
                do {
                    try! self.realm.write{
                        self.realm.add(weatherObject,update: true)
                    }
                   
                }
            }
            completed(true)
        })
        
    }
}
