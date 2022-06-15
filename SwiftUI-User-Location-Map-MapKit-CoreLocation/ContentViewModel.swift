//
//  ContentViewModel.swift
//  SwiftUI-User-Location-Map-MapKit-CoreLocation
//
//  Created by Leandro Alves da Silva on 14/06/22.
//

import MapKit

enum MapDetails {
    static let startLocation = CLLocationCoordinate2D(latitude: -16.705145, longitude: -49.331117)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startLocation, span: MapDetails.defaultSpan)
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnable() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("É Preciso usar a localizacão.")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("sua localização é restrita, provavelmente devido ao controle dos pais")
        case .denied:
            print("você negou a permissão de localização deste aplicativo. vá para as configurações para alterá-lo")
        case .authorizedAlways, .authorizedWhenInUse: break
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.defaultSpan)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

