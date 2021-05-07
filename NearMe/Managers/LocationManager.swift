//
//  LocationManager.swift
//  NearMe
//
//  Created by Andrea Stevanato on 07/05/21.
//

import Foundation
import MapKit

protocol LocationManagerType {
    /// https://swiftsenpai.com/swift/define-protocol-with-published-property-wrapper/
    /// Swift (5.4) does not support property wrapper definition in a protocol
    /// We define a location publisher on the protocol
    /// and we manually expose location publisher in the location manager implementation
    var locationPublisher: Published<CLLocation?>.Publisher { get }

    func startUpdates()
    func stopUpdates()
}

class LocationManager: NSObject, ObservableObject, LocationManagerType {


    private let locationManager = CLLocationManager()

    @Published var location: CLLocation? = nil

    // Manually expose location publisher
    var locationPublisher: Published<CLLocation?>.Publisher { $location }

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func startUpdates() {
        locationManager.startUpdatingLocation()
    }

    func stopUpdates() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        DispatchQueue.main.async {
            self.location = location
        }
    }
}
