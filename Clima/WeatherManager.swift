//
//  WeatherManager.swift
//  Clima
//
//  Created by Jose Gualberto Monfortte Flores on 02/11/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager :WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid="
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWheather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        //        1.- Create URl
        if let url = URL(string: urlString){
            //            2.- Create Url session
            let session = URLSession(configuration: .default)
            //            3.- Give a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    // in newest version of swift seems self is unnecessary
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather) //
                    }
                }
            }
            //            4.- start a task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.name)
            print(decodedData.main.temp)
            print(decodedData.weather[0].description)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            print(weather.conditionName)
            print(weather.temperatureString)
            return weather
        } catch {
            print(error)
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
