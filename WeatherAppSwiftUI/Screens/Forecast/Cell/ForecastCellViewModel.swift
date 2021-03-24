//
//  ForecastCellViewModel.swift
//  WeatherAppSwiftUI
//
//  Created by Aliona Starunska on 22.03.2021.
//

import SwiftUI
import Combine

class ForecastSectionViewModel: ObservableObject, Identifiable {
    
    var headerText: String
    var dailyViewModels: [ForecastCellViewModel]
    
    internal init(headerText: String, dailyViewModels: [ForecastCellViewModel]) {
        self.headerText = headerText
        self.dailyViewModels = dailyViewModels
    }
}

class ForecastCellViewModel: ObservableObject, Identifiable {
    
    let weaher: WeatherDetails
    
    init(weaher: WeatherDetails) {
        self.weaher = weaher
    }
}
