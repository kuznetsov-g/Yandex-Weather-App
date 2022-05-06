//
//  WeatherInfo.swift
//  Weather App
//
//  Created by Георгий Кузнецов on 06.05.2022.
//

import Foundation
import UIKit



class CityWeatherInfo {
    let topCurrentTemperature: String
    let topImage: UIImage
    let weekDayWeather: [WeekDayWeather]
    
    init(topCurrentTemperature: String, topImage: UIImage,weekDayWeather: [WeekDayWeather]) {
        self.topCurrentTemperature = topCurrentTemperature
        self.topImage = topImage
        self.weekDayWeather = weekDayWeather
    }
}
