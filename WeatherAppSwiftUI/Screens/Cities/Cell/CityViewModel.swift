//
//  CityViewModel.swift
//  WeatherAppSwiftUI
//
//  Created by Aliona Starunska on 21.03.2021.
//

import SwiftUI
import Combine

class CityViewModel: ObservableObject, Identifiable {
    
    let city: City
    
    init(city: City) {
        self.city = city
    }
    
}
