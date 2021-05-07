//
//  MKCoordinateRegion+.swift
//  NearMe
//
//  Created by Andrea Stevanato on 07/05/21.
//

import Foundation
import MapKit

extension MKCoordinateRegion {

    static var `default`: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45.48810309570, longitude: 12.044180938861),
                           span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    }
}
