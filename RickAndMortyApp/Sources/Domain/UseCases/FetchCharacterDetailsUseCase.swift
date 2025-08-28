//
//  FetchCharacterDetailsUseCase.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 26/08/2025.
//


protocol FetchCharacterDetailsUseCaseProtocol {
    func execute(id: Int, completion: @escaping (Result<RMCharacter, Error>) -> Void)
}


final class FetchCharacterDetailsUseCase: FetchCharacterDetailsUseCaseProtocol {
    private let repository: CharactersRepository
    
    init(repository: CharactersRepository) {
        self.repository = repository
    }

    func execute(id: Int, completion: @escaping (Result<RMCharacter, Error>) -> Void) {
        repository.fetchCharacterDetails(id: id, completion: completion)
    }
}
