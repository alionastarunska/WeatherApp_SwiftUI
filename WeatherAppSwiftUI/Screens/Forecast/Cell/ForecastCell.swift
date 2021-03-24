//
//  ForecastCell.swift
//  WeatherAppSwiftUI
//
//  Created by Aliona Starunska on 22.03.2021.
//

import SwiftUI

struct ForecastCell: View {
    
    @ObservedObject var viewModel: ForecastCellViewModel
    
    var body: some View {
        HStack {
            Text(viewModel.weaher.date?.string ?? "")
                .foregroundColor(.white)
            Spacer()
            Text(viewModel.weaher.main.temperature.temperatureToString)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.black)
        .cornerRadius(10)
        .padding(.horizontal, 8)
    }
}

private extension Date {
    var string: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}
