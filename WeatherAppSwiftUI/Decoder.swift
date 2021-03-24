//
//  Decoding.swift
//  WeatherAppSwiftUI
//
//  Created by Aliona Starunska on 19.03.2021.
//

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, WError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            .parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
}
