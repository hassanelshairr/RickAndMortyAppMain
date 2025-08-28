//
//  CharactersRepositoryImpl.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 26/08/2025.
//

final class CharactersRepositoryImpl: CharactersRepository {
    private let service: CharactersService
    
    init(service: CharactersService) {
        self.service = service
    }
    
    func fetchCharacters(
        page: Int,
        status: CharacterStatusFilter,
        completion: @escaping (Result<APIResponse, Error>) -> Void
    ) {
        service.fetchCharacters(page: page, status: status, completion: completion)
    }
    
    func fetchCharacterDetails(
          id: Int,
          completion: @escaping (Result<RMCharacter, Error>) -> Void
      ) {
          service.fetchCharacterDetails(id: id, completion: completion)
      }
}
