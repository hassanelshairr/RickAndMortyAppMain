//
//  APIResponse.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 28/08/2025.
//

import Foundation

struct APIResponse: Codable {
    let info: APIInfo
    let results: [RMCharacter]
}

struct APIInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
