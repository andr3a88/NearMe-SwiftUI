//
//  LandmarkViewModel.swift
//  NearMe
//
//  Created by Andrea Stevanato on 07/05/21.
//

import Foundation
import MapKit

protocol LandmarkViewModelType {
    var id: UUID { get }
    var placemark: MKPlacemark { get }
    var name: String { get }
    var title: String { get }
    var coordinate: CLLocationCoordinate2D { get }
}

struct LandmarkViewModel: LandmarkViewModelType, Identifiable {
    let id = UUID()
    let placemark: MKPlacemark

    var name: String {
        placemark.name ?? ""
    }

    var title: String {
        placemark.title ?? ""
    }

    var coordinate: CLLocationCoordinate2D {
        placemark.coordinate
    }
}
