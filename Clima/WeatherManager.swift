//
//  WeatherManager.swift
//  Clima
//
//  Created by Jose Gualberto Monfortte Flores on 02/11/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = ""
    
    func fetchWheather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        //        1.- Create URl
        if let url = URL(string: urlString){
            //            2.- Create Url session
            let session = URLSession(configuration: .default)
            //            3.- Give a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data{
                    self.parseJSON(weatherData: safeData) // in newest version of swift seems self is unnecessary
                }
            }
            //            4.- start a task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.name)
            print(decodedData.main.temp)
            print(decodedData.weather[0].description)
        } catch {
            print(error)
        }
        }
       
}
