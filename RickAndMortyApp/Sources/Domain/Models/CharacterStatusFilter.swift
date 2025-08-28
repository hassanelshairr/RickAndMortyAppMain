//
//  CharacterStatusFilter.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 26/08/2025.
//

import Foundation

enum CharacterStatusFilter: String, CaseIterable {
    case all = "All"
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"

    var queryItem: URLQueryItem? {
        switch self {
        case .all: return nil
        case .alive, .dead, .unknown:
            return URLQueryItem(name: "status", value: self.rawValue.lowercased())
        }
    }
}
