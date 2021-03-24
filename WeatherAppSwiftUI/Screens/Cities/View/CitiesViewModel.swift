//
//  CitiesViewModel.swift
//  WeatherAppSwiftUI
//
//  Created by Aliona Starunska on 20.03.2021.
//

import SwiftUI
import Combine

class CitiesViewModel: ObservableObject {
    
    @Published var city: String = ""
    @Published var selectedCity: City?
    @Published var dataSource: [CityViewModel] = []
    @Published var isLoadingView = false
    @Published var errorText: String?
    private var disposables = Set<AnyCancellable>()
    
    private let cityService: CityService
    private let weatherService: WeatherService
    
    init(cityService: CityService = ServiceFactory.shared.makeCityService(),
         weatherService: WeatherService = ServiceFactory.shared.makeWeatherService()) {
        self.cityService = cityService
        self.weatherService = weatherService
    }
    
    // MARK: - Public
    
    func getWeatherForCity(with name: String) {
        guard !name.isEmpty else { return }
        guard let city = cityService.addCity(with: name) else { return }
        isLoadingView = true
        fetchWeather(for: city)
    }
    
    func update() {
        cityService.getCities().forEach({
            fetchWeather(for: $0)
        })
    }
    
    // MARK: - Private
    
    private func fetchWeather(for city: City) {
        weatherService.getWeather(for: city)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                self.city = ""
//                self.isLoadingView = false
                switch value {
                case .failure(let reason):
                    self.errorText = reason.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] details in
                guard let self = self else { return }
                self.isLoadingView = false
                city.todayWeather = details
                self.dataSource.append(CityViewModel(city: city))
                self.city = ""
            })
            .store(in: &disposables)
    }
}
