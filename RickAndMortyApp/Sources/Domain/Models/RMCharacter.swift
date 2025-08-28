//
//  RMCharacter.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 26/08/2025.
//

import Foundation

struct RMCharacter: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: RMLocationRef
    let location: RMLocationRef
    let image: String
    let episode: [String]
    let url: String
    let created: String

    // Equality based on ID only
    static func == (lhs: RMCharacter, rhs: RMCharacter) -> Bool {
        return lhs.id == rhs.id
    }

    // Hashing based on ID only
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
