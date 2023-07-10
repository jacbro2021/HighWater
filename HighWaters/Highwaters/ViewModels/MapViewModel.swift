//
//  ContentViewModel.swift
//  Highwaters
//
//  Created by jacob brown on 7/9/23.
//

import Foundation
import CoreLocation
import MapKit

class ContentViewModel: ObservableObject {
    @Published var region: MKCoordinateRegion
    @Published var floodLocations: [FloodLocation] = []
    
    private let manager = LocationManager()
    private var latitude = 0.0
    private var longitude = 0.0
    
    init() {
        region = MKCoordinateRegion()
        manager.delegate = self
        manager.requestLocation()
    }
    
    func addFloodLocation() {
        manager.requestLocation()
        let loc = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let newLocation = FloodLocation(Coordinates: loc)
        floodLocations.append(newLocation)
    }
}

extension ContentViewModel: LocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocation location: Location) {
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.Latitude, longitude: location.Longitude), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        latitude = location.Latitude
        longitude = location.Longitude
    }
    
    func locationManager(_ manager: CLLocationManager, didFailError error: Error) {
        fatalError(error.localizedDescription)
    }
}
