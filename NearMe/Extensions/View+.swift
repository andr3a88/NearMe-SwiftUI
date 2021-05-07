//
//  View+.swift
//  NearMe
//
//  Created by Andrea Stevanato on 07/05/21.
//

import SwiftUI

extension View {

    func rounded(cornerRadius: CGFloat = 15.0) -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
}
