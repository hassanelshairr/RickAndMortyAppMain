//
//  Untitled.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 26/08/2025.
//

// MARK: - UseCase
final class FetchCharactersUseCase {
    private let repository: CharactersRepository
    
    init(repository: CharactersRepository) {
        self.repository = repository
    }
    
    func execute(
        page: Int,
        status: CharacterStatusFilter,
        completion: @escaping (Result<APIResponse, Error>) -> Void
    ) {
        repository.fetchCharacters(page: page, status: status, completion: completion)
    }
}
