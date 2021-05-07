//
//  LandmarkCategoryView.swift
//  NearMe
//
//  Created by Andrea Stevanato on 07/05/21.
//

import MapKit
import SwiftUI

struct LandmarkCategoryView: View {

    let categories = ["Restaurant", "Pizzeria", "Hotels", "Gas", "Bar", "Cinema"]
    let onSelectedCategory: (String) -> ()
    @State private var selected: String = ""

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        selected = category
                        onSelectedCategory(category)
                    }, label: {
                        Text(category)
                    }).padding(10)
                    .foregroundColor(selected == category ? Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) : Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)))
                    .background(selected == category ? Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)) : Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .rounded()
                }
            }
        }
    }
}

struct LandmarkCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkCategoryView(onSelectedCategory: { _ in })
    }
}
