//
//  ContentViewModel.swift
//  Highwaters
//
//  Created by jacob brown on 7/9/23.
//

import Foundation
import CoreLocation
import MapKit
import FirebaseDatabase

class ContentViewModel: ObservableObject {
    @Published var region: MKCoordinateRegion
    @Published var floodLocations: [FloodLocation] = []
    
    private let manager = LocationManager()
    private var rootRef: DatabaseReference!
    private var latitude = 0.0
    private var longitude = 0.0
    
    
    init() {
        region = MKCoordinateRegion()
        manager.delegate = self
        manager.requestLocation()
        
        rootRef = Database.database().reference()
        populateFloodedRegions()
    }
    
    func populateFloodedRegions() {
        let floodedRegionsRef = rootRef.child("flooded-regions")
        floodedRegionsRef.observe(.value) { snapshot in
            
            self.floodLocations = []
            
            let floodDictionaries = snapshot.value as? [String:Any] ?? [:]
            
            for (key, _) in floodDictionaries {
                
                if let floodDict = floodDictionaries[key] as? [String:Any] {
                   
                    if let flood = Location(dictionary: floodDict) {
                        self.floodLocations.append(FloodLocation(Coordinates: CLLocationCoordinate2D(latitude: flood.Latitude, longitude: flood.Longitude)))
                    }
                }
            }
        }
    }
    
    func addFloodLocation() {
        manager.requestLocation()
        let loc = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let newLocation = FloodLocation(Coordinates: loc)
        floodLocations.append(newLocation)
        
        let floodedRegionsRef = rootRef.child("flooded-regions")
        let floodRef = floodedRegionsRef.childByAutoId()
        floodRef.setValue(Location(Latitude: latitude, Longitude: longitude).toDictionary())
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
