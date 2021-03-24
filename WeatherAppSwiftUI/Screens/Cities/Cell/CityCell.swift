//
//  CityCell.swift
//  WeatherAppSwiftUI
//
//  Created by Aliona Starunska on 21.03.2021.
//

import SwiftUI

struct CityCell: View {

    @ObservedObject private var viewModel: CityViewModel

    
    init(viewModel: CityViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Text("\(viewModel.city.name)")
                .foregroundColor(.white)
            Spacer()
            Text(viewModel.city.todayWeather?.main.temperature.temperatureToString ?? "")
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.black)
        .cornerRadius(10)
        .padding(.horizontal, 8)
    }
}

struct CityCell_Previews: PreviewProvider {
    static var previews: some View {
        CityCell(viewModel: CityViewModel(city: City(name: "Kyiv")))
    }
}
