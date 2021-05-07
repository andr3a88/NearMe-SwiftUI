//
//  MapView.swift
//  NearMe
//
//  Created by Andrea Stevanato on 07/05/21.
//

import MapKit
import SwiftUI

struct MapView: View {

    @ObservedObject private var viewModel: PlaceListViewModel
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var isDragged: Bool = false

    init(viewModel: PlaceListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Map(coordinateRegion: getRegion(),
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode,
            annotationItems: viewModel.landmarks,
            annotationContent: { landmark in
                MapMarker(coordinate: landmark.coordinate)
            })
            .gesture(DragGesture()
                        .onChanged({ (value) in
                            isDragged = true
                        })
            ).overlay(addRecenterButton(), alignment: .bottom )
    }


    @ViewBuilder func addRecenterButton() -> some View {
        if isDragged {
            RecenterButton {
                viewModel.startUpdatingLocation()
                isDragged = false
            }.padding()
        } else {
            AnyView(EmptyView())
        }
    }

    private func getRegion() -> Binding<MKCoordinateRegion> {
        guard let coordinate = viewModel.currentLocation else {
            return .constant(MKCoordinateRegion.default)
        }
        return .constant(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    }
}
