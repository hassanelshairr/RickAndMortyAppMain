//
//  CharacterDetailsViewModelTests.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 27/08/2025.
//

@testable import RickAndMortyApp
import Testing
import Foundation

struct MockFetchCharacterDetailsUseCase: FetchCharacterDetailsUseCaseProtocol {
    var result: Result<RMCharacter, Error>
    
    func execute(id: Int, completion: @escaping (Result<RMCharacter, Error>) -> Void) {
        completion(result)
    }
}

struct CharacterDetailsViewModelTests {
    
    @Test("loadCharacter successfully updates character")
    func testLoadCharacterSuccess() async throws {
        // Given
        let dummyCharacter = RMCharacter(
            id: 1,
            name: "Morty Smith",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: RMLocationRef(name: "Earth", url: ""),
            location: RMLocationRef(name: "Earth", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
            episode: [],
            url: "",
            created: ""
        )
        
        let useCase = MockFetchCharacterDetailsUseCase(result: .success(dummyCharacter))
        let viewModel = CharacterDetailsViewModel(fetchCharacterDetailsUseCase: useCase, character: dummyCharacter)
        
        // When
        await withCheckedContinuation { continuation in
            viewModel.loadCharacter(id: 1)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                continuation.resume()
            }
        }
        
        // Then
        #expect(viewModel.character?.name == "Morty Smith")
        #expect(viewModel.error == nil)
        #expect(viewModel.isLoading == false)
    }
    
    @Test("loadCharacter handles error properly")
    func testLoadCharacterFailure() async throws {
        enum DummyError: Error { case failed }
        
        let dummyCharacter = RMCharacter(
            id: 1,
            name: "Morty Smith",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: RMLocationRef(name: "Earth", url: ""),
            location: RMLocationRef(name: "Earth", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
            episode: [],
            url: "",
            created: ""
        )
        
        let useCase = MockFetchCharacterDetailsUseCase(result: .failure(DummyError.failed))
        let viewModel = CharacterDetailsViewModel(fetchCharacterDetailsUseCase: useCase, character: dummyCharacter)
        
        // When
        viewModel.loadCharacter(id: 1)
        
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1s
        
        // Then
        #expect(viewModel.error != nil)
        #expect(viewModel.character?.name == "Morty Smith") // stays unchanged
        #expect(viewModel.isLoading == false)
    }

}
