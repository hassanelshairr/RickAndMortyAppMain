//
//  CharactersService.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 26/08/2025.
//

import Foundation

protocol CharactersService {
    func fetchCharacters(
        page: Int,
        status: CharacterStatusFilter?,
        completion: @escaping (Result<APIResponse, Error>) -> Void
    )
    func fetchCharacterDetails(
            id: Int,
            completion: @escaping (Result<RMCharacter, Error>) -> Void
        )
}

final class CharactersServiceImpl: CharactersService {
    private let apiClient: APIClient

    init(apiClient: APIClient = URLSessionAPIClient()) {
        self.apiClient = apiClient
    }

    func fetchCharacters(
        page: Int,
        status: CharacterStatusFilter?,
        completion: @escaping (Result<APIResponse, Error>) -> Void
    ) {
        let endpoint = CharactersEndpoint.getCharacters(page: page, status: status)
        apiClient.execute(endpoint, completion: completion)
    }
    
    func fetchCharacterDetails(
          id: Int,
          completion: @escaping (Result<RMCharacter, Error>) -> Void
      ) {
          let endpoint = CharactersEndpoint.getCharacterDetails(id: id)
          apiClient.execute(endpoint, completion: completion)
      }
}
