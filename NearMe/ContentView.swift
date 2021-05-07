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
    @State private var searchText: String = ""
    @State private var displayType: DisplayType = .map

    var body: some View {
        VStack {
            buildTextField()
            buildLandmarkCategory()
            buildPicker()
            buildBody()
        }.padding()
    }

    func buildTextField() -> some View {
        TextField("Search", text: $searchText, onEditingChanged: { _ in
        }, onCommit: {
            viewModel.searchLandmarks(searchText: searchText)
        }).textFieldStyle(RoundedBorderTextFieldStyle())
    }

    func buildLandmarkCategory() -> some View {
        LandmarkCategoryView(onSelectedCategory: { category in
            viewModel.searchLandmarks(searchText: category)
        })
    }

    func buildPicker() -> some View {
        Picker("Select", selection: $displayType, content: {
            Text("Map").tag(DisplayType.map)
            Text("List").tag(DisplayType.list)
        }).pickerStyle(SegmentedPickerStyle())
    }

    @ViewBuilder func buildBody() -> some View {
        if displayType == .map {
            MapView(viewModel: viewModel)
        } else if displayType == .list {
            LandmarkListView(landmarks: viewModel.landmarks)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
