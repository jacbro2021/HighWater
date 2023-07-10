//
//  LocationManager.swift
//  Highwaters
//
//  Created by jacob brown on 7/9/23.
//

import CoreLocation
import Foundation

protocol LocationManagerDelegate: AnyObject {
    func locationManager(_ manager: CLLocationManager, didUpdateLocation location: Location)
    func locationManager(_ manager: CLLocationManager, didFailError error: Error)
}

class LocationManager: NSObject {
    var manager: CLLocationManager = .init()
    weak var delegate: LocationManagerDelegate?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        manager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let clLocation = locations.last else { return }
        let location = Location(Latitude: clLocation.coordinate.latitude, Longitude: clLocation.coordinate.longitude)
        delegate?.locationManager(manager, didUpdateLocation: location)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.locationManager(manager, didFailError: error)
    }
}
