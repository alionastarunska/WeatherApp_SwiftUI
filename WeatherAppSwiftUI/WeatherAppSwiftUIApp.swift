//
//  WeatherAppSwiftUIApp.swift
//  WeatherAppSwiftUI
//
//  Created by Aliona Starunska on 17.03.2021.
//

import SwiftUI

@main
struct WeatherAppSwiftUIApp: App {
    var body: some Scene {
        WindowGroup<CitiesView> {
            CitiesView(viewModel: CitiesViewModel())
        }
    }
}
