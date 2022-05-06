//
//  WeekDayWeatherViewCell.swift
//  Weather App
//
//  Created by Георгий Кузнецов on 06.05.2022.
//

import UIKit

class WeekDayWeatherViewCell: UITableViewCell {

    @IBOutlet weak var weekDayWeatherImage: UIImageView!
    @IBOutlet weak var weekDay: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var dayTemp: UILabel!
    @IBOutlet weak var nightTemp: UILabel!
    
    
    func getData(weekWeather: WeekDayWeather) {
        weekDayWeatherImage.image = weekWeather.icon
        weekDay.text = weekWeather.weekDay
        condition.text = weekWeather.condition
        dayTemp.text = weekWeather.dayTemp
        nightTemp.text = weekWeather.nightTemp
    }

}
