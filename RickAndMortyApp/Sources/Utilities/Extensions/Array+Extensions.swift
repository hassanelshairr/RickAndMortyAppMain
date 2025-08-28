//
//  Array+Extensions.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 28/08/2025.
//

import Foundation

extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        Array(Set(self))
    }
}

