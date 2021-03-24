//
//  ForecastViewModel.swift
//  WeatherAppSwiftUI
//
//  Created by Aliona Starunska on 22.03.2021.
//

import SwiftUI
import Combine

class ForecastViewModel: ObservableObject, Identifiable {
    
    @Published var dataSource: [ForecastSectionViewModel] = []
    @Published var isLoadingView = false
    @Published var errorText: String?
    @Published var city: City
    private var disposables = Set<AnyCancellable>()
    
    private let cityService: CityService
    private let weatherService: WeatherService
    
    init(city: City,
         cityService: CityService = ServiceFactory.shared.makeCityService(),
         weatherService: WeatherService = ServiceFactory.shared.makeWeatherService()) {
        self.city = city
        self.cityService = cityService
        self.weatherService = weatherService
    }
    
    func update() {
        isLoadingView = true
        weatherService.getForecastWeather(for: city)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (value) in
                guard let self = self else { return }
                self.isLoadingView = false
                switch value {
                case .failure(let reason):
                    self.errorText = reason.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] forecast in
                guard let self = self else { return }
                self.isLoadingView = false
                self.city.forecastWeather = forecast.list
                self.generateDataSource(forecast: forecast.list)
            })
            .store(in: &disposables)
    }
    
    private func generateDataSource(forecast: [WeatherDetails]) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "EEEE, d MMMM"
        var dataSource = [ForecastSectionViewModel]()
        
        for weather in forecast {
            guard let date = weather.date else { continue }
            let day = dateformatter.string(from: date)
            var sectionModel: ForecastSectionViewModel? = dataSource.first(where: { $0.headerText == day })
            if sectionModel == nil {
                sectionModel = ForecastSectionViewModel(headerText: day, dailyViewModels: [])
                if let sectionModel = sectionModel {
                    dataSource.append(sectionModel)
                }
            }
            sectionModel?.dailyViewModels.append(ForecastCellViewModel(weaher: weather))
        }
        self.dataSource = dataSource
    }
}
