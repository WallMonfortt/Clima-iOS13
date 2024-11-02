//
//  weatherData.swift
//  Clima
//
//  Created by Jose Gualberto Monfortte Flores on 02/11/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}


struct Main: Decodable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
}
