//
//  Formatter.swift
//  WeatherAppSwiftUI
//
//  Created by Aliona Starunska on 18.03.2021.
//

import Foundation

let dayFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd"
    return formatter
}()

let monthFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM"
    return formatter
}()

