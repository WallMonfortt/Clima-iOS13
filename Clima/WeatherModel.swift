//
//  WeatherModule.swift
//  Clima
//
//  Created by Jose Gualberto Monfortte Flores on 03/11/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        String(format: "%.1f", temperature) + "°C"
    }
    
    var conditionName: String {
        switch conditionId {
        case (200 ... 232):
            return "cloud.bold"
        case (300 ... 321):
            return "cloud.drizzle"
        case (500 ... 531):
            return "cloud.rain"
        case (600 ... 622):
            return "cloud.snow"
        case (701 ... 781):
            return "cloud.fog"
        case (800):
            return "sun.max"
        case (801 ... 804):
            return "cloud.sun.rain"
            
        default:
            return "sun.max.trianglebadge.exclamationmark"
        }
    }
}
