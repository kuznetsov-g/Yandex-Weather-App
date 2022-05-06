//
//  ViewController.swift
//  Weather App
//
//  Created by Георгий Кузнецов on 16.04.2022.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var topCurrentTemperature: UILabel!
    @IBOutlet weak var topWeatherImage: UIImageView!
    @IBOutlet weak var topCityName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var weekWeather: [WeekDayWeather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cityMoscow = CityModel(searchName: "Moscow", delegate: self)
        topCityName.text = "chto-to tam"
        
    }
    

    
    
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weekWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekDayWeatherCell", for: indexPath) as! WeekDayWeatherViewCell
        cell.getData(weekWeather: weekWeather[indexPath.row])
        return cell
    }
    
    
}

extension WeatherViewController: CoordinateDelegate {
    func getCityData(cityData: CityDataFromJSON) {
        self.topCityName.text = cityData.cityName
        self.weekWeather = cityData.weekDayWeather
        self.topCurrentTemperature.text = cityData.topCurrentTemperature
        self.topWeatherImage.image = cityData.topImage
        tableView.reloadData()
           }
    
}


