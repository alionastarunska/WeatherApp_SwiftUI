//
//  WError.swift
//  WeatherAppSwiftUI
//
//  Created by Aliona Starunska on 19.03.2021.
//

import Foundation

enum WError: Error {
    case parsing(description: String)
    case network(description: String)
}
