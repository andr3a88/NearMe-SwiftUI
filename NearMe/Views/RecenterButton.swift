//
//  RecenterButton.swift
//  NearMe
//
//  Created by Andrea Stevanato on 07/05/21.
//

import SwiftUI

struct RecenterButton: View {

    let onTapped: () -> ()

    var body: some View {
        Button(action: onTapped, label: {
            Label("Re-center", systemImage: "map")
        })
        .padding(10)
        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        .background(Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
    }
}

struct RecenterButton_Previews: PreviewProvider {
    static var previews: some View {
        RecenterButton(onTapped: {})
    }
}
