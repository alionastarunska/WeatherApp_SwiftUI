//
//  CitiesView.swift
//  WeatherAppSwiftUI
//
//  Created by Aliona Starunska on 20.03.2021.
//

import SwiftUI

struct CitiesView: View {
    
    @ObservedObject var viewModel: CitiesViewModel
    @State var isPresentedDetails = false
    private var selectedCity: City?
    
    var body: some View {
        ZStack {
            List {
                searchField
                citiesSection
            }
            .listStyle(GroupedListStyle())
            .onAppear(perform: viewModel.update)
            
            ViewFactory.loadingView(visible: $viewModel.isLoadingView)
        }
    }
    
    init(viewModel: CitiesViewModel) {
        self.viewModel = viewModel
    }
}

private extension CitiesView {
    var searchField: some View {
        HStack(alignment: .center) {
            TextField("Search", text: $viewModel.city, onCommit:  {
                viewModel.getWeatherForCity(with: viewModel.city)
            })
        }
    }
    
    var citiesSection: some View {
        Section {
            ForEach(viewModel.dataSource) { viewModel in
                CityCell.init(viewModel: viewModel)
                    .onTapGesture {
                        self.viewModel.selectedCity = viewModel.city
                        self.isPresentedDetails = true
                    }
            }
            .sheet(isPresented: $isPresentedDetails, content: {
                ViewFactory.makeCurrentWeatherView(withCity: viewModel.dataSource.first?.city ?? City(name: ""))
            })
        }
    }
}


struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesView(viewModel: CitiesViewModel())
    }
}
