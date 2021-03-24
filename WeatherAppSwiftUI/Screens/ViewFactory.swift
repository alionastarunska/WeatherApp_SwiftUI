//
//  ViewFactory.swift
//  WeatherAppSwiftUI
//
//  Created by Aliona Starunska on 20.03.2021.
//

import SwiftUI

enum ViewFactory {
    static func makeCurrentWeatherView(withCity city: City) -> some View {
        let viewModel = ForecastViewModel(city: city)
        return ForecastView(viewModel: viewModel)
    }
    
    static func loadingView(visible: Binding<Bool>) -> some View {
        return ActivityView(visible: visible)
    }
}
