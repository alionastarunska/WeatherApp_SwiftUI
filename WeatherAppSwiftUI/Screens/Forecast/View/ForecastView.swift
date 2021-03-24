//
//  ForecastView.swift
//  WeatherAppSwiftUI
//
//  Created by Aliona Starunska on 22.03.2021.
//

import SwiftUI

struct ForecastView: View {
    
    @ObservedObject var viewModel: ForecastViewModel
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    header
                    forecastSection
                }
                .listStyle(GroupedListStyle())
                .onAppear(perform: viewModel.update)
            }
            ViewFactory.loadingView(visible: $viewModel.isLoadingView)
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(viewModel: ForecastViewModel(city: City(name: "Test")))
    }
}

private extension ForecastView {
    var header: some View {
        VStack {
            VStack {
                Text(viewModel.city.name)
                    .font(.title)
                    .foregroundColor(Color.white)
                Text(viewModel.city.todayWeather?.main.temperature.temperatureToString ?? "")
                    .fontWeight(.bold)
                    .font(.system(size: 40))
                    .foregroundColor(Color.white)
            }
            .padding(.top)
            HStack {
                Text(viewModel.city.todayWeather?.weather.first?.description.capitalized ?? "")
                    .foregroundColor(Color.white)
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("Feels like: \(viewModel.city.todayWeather?.main.feelsLike.temperatureToString ?? "")")
                    .foregroundColor(Color.white)
                Spacer()
            }
            .padding([.horizontal, .bottom])
        }
        .background(Color.black)
        .cornerRadius(10)
    }
    
    var forecastSection: some View {
        ForEach(viewModel.dataSource) { section in
            Section {
                Text(section.headerText)
                ForEach(section.dailyViewModels, content: ForecastCell.init(viewModel:))
            }
        }
        
    }
}
