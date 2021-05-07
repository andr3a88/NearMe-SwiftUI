//
//  LandmarkListView.swift
//  NearMe
//
//  Created by Andrea Stevanato on 07/05/21.
//

import SwiftUI

struct LandmarkListView: View {

    let landmarks: [LandmarkViewModel]

    var body: some View {
        List(landmarks, id: \.id) { landmark in
            VStack(alignment: .leading, spacing: 10, content: {
                Text(landmark.name)
                    .font(.headline)
                Text(landmark.title)
            })
        }
    }
}

