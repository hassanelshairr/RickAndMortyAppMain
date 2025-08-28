//
//  RoundedCorner.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 28/08/2025.
//

import SwiftUI

/// A reusable shape that allows rounding specific corners of a rectangle.
/// Useful for custom card styles, bottom sheets, etc.
struct RoundedCorner: Shape {
    var radius: CGFloat = 10
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
