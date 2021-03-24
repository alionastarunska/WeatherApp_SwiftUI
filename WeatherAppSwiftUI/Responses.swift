//
//  Responses.swift
//  WeatherAppSwiftUI
//
//  Created by Aliona Starunska on 19.03.2021.
//

import Foundation

struct WeeklyForecastResponse: Codable {
    let list: [Item]
    
    struct Item: Codable {
        let date: Date
        let main: MainClass
        let weather: [Weather]
        
        enum CodingKeys: String, CodingKey {
            case date = "dt"
            case main
            case weather
        }
    }
    
    struct MainClass: Codable {
        let temp: Double
    }
    
    struct Weather: Codable {
        let main: MainEnum
        let weatherDescription: String
        
        enum CodingKeys: String, CodingKey {
            case main
            case weatherDescription = "description"
        }
    }
    
    enum MainEnum: String, Codable {
        case clear = "Clear"
        case clouds = "Clouds"
        case rain = "Rain"
    }
}

struct CurrentWeatherForecastResponse: Decodable {
    let city: City
    let main: WeatherDetailsMain
    
    struct WeatherDetailsMain: Codable {
        
        private(set) var temperature: Float
        private(set) var feelsLike: Float
        private(set) var tempMin: Float
        private(set) var tempMax: Float
        private(set) var pressure: Int
        private(set) var humidity: Int
        
        private enum CodingKeys: String, CodingKey {
            case pressure, humidity
            case temperature = "temp"
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }
    
    struct City: Codable {
        let name: String
    }
}

struct ForecastResponse: Codable {
    var list: [WeatherDetails]
}
