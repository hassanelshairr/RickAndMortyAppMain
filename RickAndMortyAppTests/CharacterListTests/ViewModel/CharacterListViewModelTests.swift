//
//  CharacterListViewModelTests.swift
//
//  Created by hassan elshaer on 26/08/2025.
//

@testable import RickAndMortyApp
import Testing


struct MockCharactersRepository: CharactersRepository {
    var result: Result<APIResponse, Error>
    
    func fetchCharacters(
        page: Int,
        status: CharacterStatusFilter,
        completion: @escaping (Result<APIResponse, Error>) -> Void
    ) {
        completion(result)
    }
    
    func fetchCharacterDetails(
        id: Int,
        completion: @escaping (Result<RMCharacter, Error>) -> Void
    ) {
        fatalError("Not needed for these tests")
    }
}


@Test("resetAndLoad loads characters successfully")
func testResetAndLoadSuccess() async throws {
    let dummyCharacter = RMCharacter(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        origin: RMLocationRef(name: "Earth", url: ""),
        location: RMLocationRef(name: "Earth", url: ""),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: [],
        url: "",
        created: ""
    )
    
    let response = APIResponse(
        info: APIInfo(count: 0, pages: 0, next: nil, prev: nil),
        results: [dummyCharacter]
    )
    
    let repo = MockCharactersRepository(result: .success(response))
    let useCase = FetchCharactersUseCase(repository: repo)
    let viewModel = CharacterListViewModel(fetchCharactersUseCase: useCase)
    
    // Suspend until onChange is triggered
    await withCheckedContinuation { continuation in
        viewModel.onChange = {
            continuation.resume()
        }
        viewModel.resetAndLoad()
    }
    
    #expect(viewModel.characters.count == 1)
    #expect(viewModel.characters.first?.name == "Rick Sanchez")
}

@Test("resetAndLoad handles error properly")
func testResetAndLoadFailure() async throws {
    enum DummyError: Error { case failed }
    
    let repo = MockCharactersRepository(result: .failure(DummyError.failed))
    let useCase = FetchCharactersUseCase(repository: repo)
    let viewModel = CharacterListViewModel(fetchCharactersUseCase: useCase)
    
    var receivedError: Error?
    
    // Suspend until onError is triggered
    await withCheckedContinuation { continuation in
        viewModel.onError = { error in
            receivedError = error
            continuation.resume()
        }
        viewModel.resetAndLoad()
    }
    
    #expect(viewModel.characters.isEmpty)
    #expect(receivedError != nil)
}
