//
//  CharacterListViewModelTests.swift
//
//  Created by hassan elshaer on 26/08/2025.
//

@testable import RickAndMortyApp
import Testing
import Foundation

// MARK: - Mock Repo
struct MockCharactersRepository: CharactersRepository {
    var resultForPage: [Int: Result<APIResponse, Error>]

    func fetchCharacters(
        page: Int,
        status: CharacterStatusFilter,
        completion: @escaping (Result<APIResponse, Error>) -> Void
    ) {
        if let result = resultForPage[page] {
            completion(result)
        } else {
            completion(.failure(NSError(domain: "NoResult", code: 0)))
        }
    }

    func fetchCharacterDetails(
        id: Int,
        completion: @escaping (Result<RMCharacter, Error>) -> Void
    ) {
        fatalError("Not needed for these tests")
    }
}

// MARK: - Helpers
extension RMCharacter {
    static func dummy(
        id: Int,
        name: String = "Dummy",
        status: String = "Alive"
    ) -> RMCharacter {
        RMCharacter(
            id: id,
            name: name,
            status: status,
            species: "Human",
            type: "",
            gender: "Male",
            origin: RMLocationRef(name: "Earth", url: ""),
            location: RMLocationRef(name: "Earth", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/\(id).jpeg",
            episode: [],
            url: "",
            created: ""
        )
    }
}
// MARK: - Tests

@Test("resetAndLoad loads characters successfully")
func testResetAndLoadSuccess() async throws {
    let response = APIResponse(info: APIInfo(count: 0, pages: 1, next: nil, prev: nil),
                               results: [.dummy(id: 1, name: "Rick Sanchez")])
    
    let repo = MockCharactersRepository(resultForPage: [1: .success(response)])
    let useCase = FetchCharactersUseCase(repository: repo)
    let viewModel = CharacterListViewModel(fetchCharactersUseCase: useCase)
    
    await withCheckedContinuation { continuation in
        viewModel.onChange = { continuation.resume() }
        viewModel.resetAndLoad()
    }
    
    #expect(viewModel.characters.count == 1)
    #expect(viewModel.characters.first?.name == "Rick Sanchez")
}

@Test("resetAndLoad handles error properly")
func testResetAndLoadFailure() async throws {
    enum DummyError: Error { case failed }
    
    let repo = MockCharactersRepository(resultForPage: [1: .failure(DummyError.failed)])
    let useCase = FetchCharactersUseCase(repository: repo)
    let viewModel = CharacterListViewModel(fetchCharactersUseCase: useCase)
    
    var receivedError: Error?
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

@Test("pagination loads additional pages")
func testPagination() async throws {
    let page1 = APIResponse(info: APIInfo(count: 0, pages: 2, next: nil, prev: nil),
                            results: [.dummy(id: 1, name: "Rick")])
    let page2 = APIResponse(info: APIInfo(count: 0, pages: 2, next: nil, prev: nil),
                            results: [.dummy(id: 2, name: "Morty")])
    
    let repo = MockCharactersRepository(resultForPage: [
        1: .success(page1),
        2: .success(page2)
    ])
    let useCase = FetchCharactersUseCase(repository: repo)
    let viewModel = CharacterListViewModel(fetchCharactersUseCase: useCase)
    
    // Load first page
    await withCheckedContinuation { continuation in
        viewModel.onChange = { continuation.resume() }
        viewModel.resetAndLoad()
    }
    #expect(viewModel.characters.count == 1)
    
    // Load second page
    await withCheckedContinuation { continuation in
        viewModel.onChange = { continuation.resume() }
        viewModel.loadMoreIfNeeded(currentIndex: viewModel.characters.count - 1)
    }
    #expect(viewModel.characters.count == 2)
}

@Test("user selecting .alive filter loads only alive characters")
func testSelectingAliveFilter() async throws {
    let aliveResponse = APIResponse(
        info: APIInfo(count: 1, pages: 1, next: nil, prev: nil),
        results: [.dummy(id: 1, name: "Rick", status: "Alive")]
    )
    
    let repo = MockCharactersRepository(resultForPage: [1: .success(aliveResponse)])
    let useCase = FetchCharactersUseCase(repository: repo)
    let viewModel = CharacterListViewModel(fetchCharactersUseCase: useCase)
    
    var updatedCharacters: [RMCharacter] = []
    await withCheckedContinuation { continuation in
        viewModel.onChange = {
            updatedCharacters = viewModel.characters
            continuation.resume()
        }
        // simulate user selecting alive filter
        viewModel.statusFilter = .alive
    }
    
    #expect(updatedCharacters.allSatisfy { $0.status == "Alive" })
}

@Test("user selecting .dead filter loads only dead characters")
func testSelectingDeadFilter() async throws {
    let deadResponse = APIResponse(
        info: APIInfo(count: 1, pages: 1, next: nil, prev: nil),
        results: [.dummy(id: 2, name: "Morty", status: "Dead")]
    )
    
    let repo = MockCharactersRepository(resultForPage: [1: .success(deadResponse)])
    let useCase = FetchCharactersUseCase(repository: repo)
    let viewModel = CharacterListViewModel(fetchCharactersUseCase: useCase)
    
    var updatedCharacters: [RMCharacter] = []
    await withCheckedContinuation { continuation in
        viewModel.onChange = {
            updatedCharacters = viewModel.characters
            continuation.resume()
        }
        // simulate user selecting dead filter
        viewModel.statusFilter = .dead
    }
    
    #expect(updatedCharacters.allSatisfy { $0.status == "Dead" })
}
