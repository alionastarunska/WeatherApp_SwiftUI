//
//  Float+TemperatureString.swift
//  WeatherAppSwiftUI
//
//  Created by Aliona Starunska on 19.03.2021.
//

import SwiftUI

struct ActivityView: View {
    
    @Binding var visible: Bool 
    
    var body: some View {
        if visible == true {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        }
    }
}
