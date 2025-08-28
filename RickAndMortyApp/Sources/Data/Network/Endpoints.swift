//
//  Endpoints.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 26/08/2025.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var urlRequest: URLRequest? { get }
}

extension Endpoint {
    var urlRequest: URLRequest? {
        var comps = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        comps?.queryItems = queryItems
        guard let url = comps?.url else { return nil }
        return URLRequest(url: url)
    }
}

// MARK: - Characters Endpoint
enum CharactersEndpoint: Endpoint {
    case getCharacters(page: Int, perPage: Int = 20, status: CharacterStatusFilter?)
    case getCharacterDetails(id: Int)

    var baseURL: URL {
        URL(string: "https://rickandmortyapi.com/api")!
    }

    var path: String {
        switch self {
        case .getCharacters:
            return "/character"
        case .getCharacterDetails(let id):
            return "/character/\(id)"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case let .getCharacters(page, perPage, status):
            var items = [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "count", value: String(perPage))
            ]
            if let status = status, let item = status.queryItem {
                items.append(item)
            }
            return items

        case .getCharacterDetails:
            return []
        }
    }
}
