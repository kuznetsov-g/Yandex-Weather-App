//
//  CityModel.swift
//  Weather App
//
//  Created by Георгий Кузнецов on 03.05.2022.
//

import Foundation
import UIKit
protocol CoordinateDelegate {
    func getCityData(cityData: CityDataFromJSON)
}

class CityModel {
    private var cityName = ""
    var searchName = ""
//    var topCurrentTemperature: String
//    var topWeatherImage: UIImage
//    var weekWeather: [WeekDayWeather] = []
    var delegate: CoordinateDelegate!
    
    init(searchName: String, delegate: CoordinateDelegate) {
        self.searchName = searchName
        self.delegate = delegate
        self.getcityData()
    }
    
    private func getcityData() {
        let apiKey = "23828a58-4738-4bac-8372-18ad369a78d7"
        guard let geoURL = URL(string: "https://geocode-maps.yandex.ru/1.x/?format=json&apikey="+apiKey+"&geocode="+searchName+"&results=1") else { return }
        
        URLSession.shared.dataTask(with: geoURL) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "we have no one error 😉")
                return
            }
                do {
                    let cityData = try JSONDecoder().decode(CityData.self, from: data)
                    DispatchQueue.main.async {
                    self.getCityCoordinates(cityData: cityData)
                    }
                    } catch let error {
                    print(error.localizedDescription)
                }
        }.resume()
    }
    
    func getCityCoordinates(cityData: CityData) -> () {
        let allCoordinates = cityData.response.GeoObjectCollection.featureMember[0].GeoObject.Point.pos
        let coordinatesArray = allCoordinates.components(separatedBy: " ")
        let longCoordinate = coordinatesArray[0]
        let latCoordinate  = coordinatesArray[1]
        self.cityName = cityData.response.GeoObjectCollection.featureMember[0].GeoObject.name
        
        let _ = WeatherModel(latCoordinate: latCoordinate, longCoordinate: longCoordinate, delegate: self)
        
    }
        }

extension CityModel: CityWeatherDelegate {
    func getCityWeather(topCurrentTemperature: String, topImage: UIImage, weekDayWeather: [WeekDayWeather]) {
        let cityData = CityDataFromJSON(cityName: self.cityName
                                        , topCurrentTemperature: topCurrentTemperature
                                        , topImage: topImage
                                        , weekDayWeather: weekDayWeather)
 
        delegate.getCityData(cityData: cityData)
    }
    
    
}

Ç
struct CityDataFromJSON {
    let cityName: String
    let topCurrentTemperature: String
    let topImage: UIImage
    let weekDayWeather: [WeekDayWeather]
    
}
