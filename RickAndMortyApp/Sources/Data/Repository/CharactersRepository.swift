//
//  CharactersRepository.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 26/08/2025.
//

protocol CharactersRepository {
    func fetchCharacters(
        page: Int,
        status: CharacterStatusFilter,
        completion: @escaping (Result<APIResponse, Error>) -> Void
    )
    
    func fetchCharacterDetails(
           id: Int,
           completion: @escaping (Result<RMCharacter, Error>) -> Void
       )
}
