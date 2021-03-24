//
//  WeatherService.swift
//  Homework_4
//
//  Created by Aliona Starunska on 18.01.2021.
//

import Foundation
import Combine

protocol WeatherService {
    
    func getWeather(for city: City) -> AnyPublisher<WeatherDetails, WError>
    func getForecastWeather(for city: City) -> AnyPublisher<ForecastResponse, WError>
}

class DefaultWeatherService {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - WeatherService

extension DefaultWeatherService: WeatherService {
    
    func getForecastWeather(for city: City) -> AnyPublisher<ForecastResponse, WError> {
        return forecast(with: makeForecastComponents(withCity: city))
    }
    
    func getWeather(for city: City) -> AnyPublisher<WeatherDetails, WError> {
        return forecast(with: makeWeatherComponents(withCity: city))
    }
    
    private func forecast<T>(with components: URLComponents) -> AnyPublisher<T, WError> where T: Decodable {
        guard let url = components.url else {
            let error = WError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}

private extension DefaultWeatherService {
    struct API {
        static let host = "https://api.openweathermap.org"
        static let path = "/data/2.5"
        static let key = "58eef5bfd9733607c7649ca2a23f355e"
    }
    
    func makeForecastComponents(withCity city: City) -> URLComponents {
        guard let url = URL(string: API.host + API.path + "/forecast") else { return URLComponents() }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        components?.queryItems = [
            URLQueryItem(name: "q", value: city.name),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: API.key)
        ]
        
        return components ?? URLComponents()
    }
    func makeWeatherComponents(withCity city: City) -> URLComponents {
        guard let url = URL(string: API.host + API.path + "/weather") else { return URLComponents() }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        components?.queryItems = [
            URLQueryItem(name: "q", value: city.name),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: API.key)
        ]
        
        return components ?? URLComponents()
    }
}
