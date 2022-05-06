//
//  WeatherModel.swift
//  Weather App
//
//  Created by Георгий Кузнецов on 03.05.2022.
//

import UIKit

protocol CityWeatherDelegate {
   func getCityWeather(topCurrentTemperature: String, topImage: UIImage, weekDayWeather: [WeekDayWeather])
}
class WeatherModel {
    var latCoordinate: String
    var longCoordinate: String
    var delegate: CityWeatherDelegate!
    
    init(latCoordinate: String, longCoordinate: String, delegate: CityWeatherDelegate) {
        self.latCoordinate = latCoordinate
        self.longCoordinate = longCoordinate
        self.delegate = delegate
       getWeatherData()
    }
    
    private func getWeatherData() {
        let apiKey = "abbbc5b9429543f9b3bd8041faf821e9"
        guard let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat="+latCoordinate+"&lon="+longCoordinate+"&cnt=7&appid="+apiKey+"&exclude=minutely,hourly,alerts&units=metric")
        else {print("priblem with weather URL")
             return }
        
        URLSession.shared.dataTask(with: weatherURL) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "we have no one error in weather JSON 😉")
                return
            }
            do { print("data is data")
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    self.getWeatherInfo(weatherData: weatherData)
                }
               } catch let error {
                print("error is here: \(error)")
            }
        }.resume()
    }
    
     func getImage(iconName: String) -> UIImage {
        guard let imageURL = URL(string: "https://openweathermap.org/img/wn/"+iconName+"@2x.png") else { return UIImage() }
        guard let imageData = try? Data(contentsOf: imageURL) else { return UIImage() }
        guard let image = UIImage(data: imageData) else { return UIImage() }
        return image
        }
    
    private func getWeatherInfo(weatherData: WeatherData) {
        let topCurrentTemp = String(Int(weatherData.current.temp)) + " °C"
        let topImage = self.getImage(iconName: weatherData.current.weather[0].icon)
        var weekdayWeatherArray : [WeekDayWeather] = []
        
        for i in 0...weatherData.daily.count - 1 {
            let daileData = weatherData.daily[i]
            let weekDay: String
            let condition: String
            let dayTemp: String
            let nightTemp: String
            let formatter = DateFormatter()
            var icon: UIImage
            formatter.setLocalizedDateFormatFromTemplate("EEEE")
            
            weekDay = formatter.string(from:  Date(timeIntervalSince1970: Double(daileData.dt)))
            condition = daileData.weather[0].main
            dayTemp = String(Int(daileData.temp.day))
            nightTemp = String(Int(daileData.temp.night))
            icon = self.getImage(iconName: daileData.weather[0].icon)
            weekdayWeatherArray += [WeekDayWeather( weekDay: weekDay
                                                  , condition: condition
                                                  , dayTemp: dayTemp
                                                  , nightTemp: nightTemp
                                                  , icon: icon)
                                   ]
        }
        
        
        delegate.getCityWeather ( topCurrentTemperature: topCurrentTemp
                                , topImage: topImage
                                , weekDayWeather: weekdayWeatherArray)
    }
}



