//
//  ContentView.swift
//  NearMe
//
//  Created by Andrea Stevanato on 07/05/21.
//

import MapKit
import SwiftUI

enum DisplayType {
    case map
    case list
}

struct ContentView: View {

    @StateObject private var viewModel = PlaceListViewModel()
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var searchText: String = ""
    @State private var displayType: DisplayType = .map
    @State private var isDragged: Bool = false

    private func getRegion() -> Binding<MKCoordinateRegion> {
        guard let coordinate = viewModel.currentLocation else {
            return .constant(MKCoordinateRegion.default)
        }
        return .constant(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    }

    var body: some View {
        VStack {
            TextField("Search", text: $searchText, onEditingChanged: { _ in
            }, onCommit: {
                viewModel.searchLandmarks(searchText: searchText)
            }).textFieldStyle(RoundedBorderTextFieldStyle())

            LandmarkCategoryView(onSelectedCategory: { category in
                viewModel.searchLandmarks(searchText: category)
            })

            Picker("Select", selection: $displayType, content: {
                Text("Map").tag(DisplayType.map)
                Text("List").tag(DisplayType.list)
            }).pickerStyle(SegmentedPickerStyle())

            if displayType == .map {
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
                    ).overlay(isDragged ? AnyView(RecenterButton {
                        viewModel.startUpdatingLocation()
                        isDragged = false
                    }.padding()) : AnyView(EmptyView()), alignment: .bottom )
            } else if displayType == .list {
                LandmarkListView(landmarks: viewModel.landmarks)
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
