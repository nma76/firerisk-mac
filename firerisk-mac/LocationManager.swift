//
//  LocationManager.swift
//  firerisk-mac
//
//  Created by Jonas Lindau on 2026-04-03.
//

import Foundation
import CoreLocation
import MapKit
internal import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var latitude: Double?
    @Published var longitude: Double?
    @Published var city: String?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        print("didUpdateLocations:", location.coordinate)

        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        reverseGeocode(location)
    }
    
    func reverseGeocode(_ location: CLLocation) {
        let request = MKLocalPointsOfInterestRequest(center: location.coordinate, radius: 5000)
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let mapItem = response?.mapItems.first else { return }
            
            DispatchQueue.main.async {
                self.city = mapItem.addressRepresentations?.cityName
            }
        }
    }
}
