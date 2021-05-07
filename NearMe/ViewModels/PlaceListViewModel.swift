//
//  PlaceListViewModel.swift
//  NearMe
//
//  Created by Andrea Stevanato on 07/05/21.
//

import Combine
import Foundation
import MapKit

protocol PlaceListViewModelType {
    var locationManager: LocationManagerType { get }

    init(locationManager: LocationManagerType)

    func searchLandmarks(searchText: String)
    func startUpdatingLocation()
}

class PlaceListViewModel: ObservableObject {

    private let locationManager: LocationManagerType
    var cancellable: AnyCancellable?

    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var landmarks: [LandmarkViewModel] = []

    init(locationManager: LocationManagerType = LocationManager()) {
        self.locationManager = locationManager

        cancellable = self.locationManager.locationPublisher.sink { (location) in
            guard let location = location else { return }
            
            DispatchQueue.main.async {
                self.currentLocation = location.coordinate
                self.locationManager.stopUpdates()
            }
        }
    }

    func searchLandmarks(searchText: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let error = error {
                print(error)
            } else if let response = response {
                self.landmarks = response.mapItems.map { LandmarkViewModel(placemark: $0.placemark) }
            }
        }
    }

    func startUpdatingLocation() {
        locationManager.startUpdates()
    }
}
