//
//  ContentView.swift
//  SwiftUI-User-Location-Map-MapKit-CoreLocation
//
//  Created by Leandro Alves da Silva on 14/06/22.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .accentColor(Color(.systemPink))
            .onAppear{
            viewModel.checkIfLocationServicesIsEnable()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
