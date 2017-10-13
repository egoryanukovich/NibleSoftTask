//
//  HistoryCell.swift
//  NibleSoftTask
//
//  Created by Egor Yanukovich on 10/12/17.
//  Copyright © 2017 Egor Yanukovich. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureWithContactEntry(_ weather: WeatherModel) {
        DispatchQueue.main.async {
        
            self.dateLabel.text = self.formatDate(weather.requestDate!)
        }
        
        cityNameLabel.text = formatAddress(address: weather.address!)
        
        latitudeLabel.text = weather.latitude
        longitudeLabel.text = weather.longitude
        
    }
    
    func formatDate(_ date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        dateFormatter.dateFormat = "MMM dd,yyyy hh:mm a"
        let dayString = dateFormatter.string(from: date)
        
        return dayString
    }
    
    func formatAddress(address : String) -> String{
        let fullAddress = address
        let arrayOfPlacemarks = fullAddress.components(separatedBy: ",")
        let countPlacemarks = arrayOfPlacemarks.count
        let myElement = arrayOfPlacemarks[countPlacemarks - 2]
        
        return myElement
    }
}
