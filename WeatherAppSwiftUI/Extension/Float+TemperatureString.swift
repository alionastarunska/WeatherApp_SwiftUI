//
//  Float+TemperatureString.swift
//  WeatherAppSwiftUI
//
//  Created by Aliona Starunska on 19.03.2021.
//

import Foundation

extension Optional where Wrapped == Float {
    var temperatureString: String {
        if let unwrapped = self {
            return unwrapped.temperatureToString
        } else {
            return ""
        }
    }
}

extension Float {
    var temperatureToString: String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        return (self >= 0 ? "+" : "") + (formatter.string(from: NSNumber(value: self)) ?? String(format: "%.1f", self)) + "°C"
    }
}
