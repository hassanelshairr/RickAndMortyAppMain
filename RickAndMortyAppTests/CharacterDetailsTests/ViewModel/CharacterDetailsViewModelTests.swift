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
    
    // MARK: - Existing Tests
    
    @Test("loadCharacter successfully updates character")
    func testLoadCharacterSuccess() async throws {
        let dummyCharacter = RMCharacter.dummy(id: 1, name: "Morty Smith", status: "Alive")
        
        let useCase = MockFetchCharacterDetailsUseCase(result: .success(dummyCharacter))
        let viewModel = CharacterDetailsViewModel(fetchCharacterDetailsUseCase: useCase, character: dummyCharacter)
        
        await withCheckedContinuation { continuation in
            viewModel.loadCharacter(id: 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                continuation.resume()
            }
        }
        
        #expect(viewModel.character?.name == "Morty Smith")
        #expect(viewModel.error == nil)
        #expect(viewModel.isLoading == false)
    }
    
    @Test("loadCharacter handles error properly")
    func testLoadCharacterFailure() async throws {
        enum DummyError: Error { case failed }
        
        let dummyCharacter = RMCharacter.dummy(id: 1, name: "Morty Smith", status: "Alive")
        
        let useCase = MockFetchCharacterDetailsUseCase(result: .failure(DummyError.failed))
        let viewModel = CharacterDetailsViewModel(fetchCharacterDetailsUseCase: useCase, character: dummyCharacter)
        
        viewModel.loadCharacter(id: 1)
        try await Task.sleep(nanoseconds: 100_000_000)
        
        #expect(viewModel.error != nil)
        #expect(viewModel.character?.name == "Morty Smith")
        #expect(viewModel.isLoading == false)
    }
        
    @Test("initial state reflects injected character and accessors")
    func testInitialState() async throws {
        let dummy = RMCharacter.dummy(id: 42, name: "Rick Sanchez", status: "Dead")
        let useCase = MockFetchCharacterDetailsUseCase(result: .success(dummy))
        let viewModel = CharacterDetailsViewModel(fetchCharacterDetailsUseCase: useCase, character: dummy)
        
        #expect(viewModel.character?.id == 42)
        #expect(viewModel.name == "Rick Sanchez")
        #expect(viewModel.status == "Dead")
        #expect(viewModel.species == "Human")
        #expect(viewModel.gender == "Male")
        #expect(viewModel.location == "Earth")
        #expect(viewModel.imageURL?.absoluteString.contains("avatar/42") == true)
        #expect(viewModel.error == nil)
        #expect(viewModel.isLoading == false)
    }
    
    @Test("loading sets isLoading true until completion")
    func testLoadingStateToggles() async throws {
        let dummy = RMCharacter.dummy(id: 99, name: "Summer Smith")
        
        struct DelayedUseCase: FetchCharacterDetailsUseCaseProtocol {
            func execute(id: Int, completion: @escaping (Result<RMCharacter, Error>) -> Void) {
                DispatchQueue.global().asyncAfter(deadline: .now() + 0.05) {
                    completion(.success(.dummy(id: id, name: "Summer Smith")))
                }
            }
        }
        
        let viewModel = CharacterDetailsViewModel(fetchCharacterDetailsUseCase: DelayedUseCase(), character: dummy)
        
        viewModel.loadCharacter(id: 99)
        #expect(viewModel.isLoading == true)
        
        try await Task.sleep(nanoseconds: 100_000_000)
        
        #expect(viewModel.isLoading == false) // after completion
        #expect(viewModel.character?.name == "Summer Smith")
    }
}
