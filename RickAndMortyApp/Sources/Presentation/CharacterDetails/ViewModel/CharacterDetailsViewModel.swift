//
//  CharacterDetailsViewModel.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 27/08/2025.
//

import Foundation

/// ViewModel responsible for fetching and exposing the details of a single character.
/// It handles loading state, errors, and provides convenience accessors for the SwiftUI view.
final class CharacterDetailsViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published private(set) var character: RMCharacter?
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    // MARK: - Dependencies
    private let fetchCharacterDetailsUseCase: FetchCharacterDetailsUseCaseProtocol
    
    // MARK: - Init
    init(fetchCharacterDetailsUseCase: FetchCharacterDetailsUseCaseProtocol, character: RMCharacter) {
        self.fetchCharacterDetailsUseCase = fetchCharacterDetailsUseCase
        self.character = character
    }
    
    // MARK: - Public Methods
    
    /// Loads character details from the use case by ID.
    func loadCharacter(id: Int) {
        isLoading = true
        error = nil
        fetchCharacterDetailsUseCase.execute(id: id) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let character):
                    self?.character = character
                case .failure(let error):
                    self?.error = error
                }
            }
        }
    }
    
    // MARK: - Convenience Accessors
    var name: String { character?.name ?? "" }
    var species: String { character?.species ?? "" }
    var status: String { character?.status ?? "" }
    var gender: String { character?.gender ?? "" }
    var imageURL: URL? { URL(string: character?.image ?? "") }
    var location: String { character?.location.name ?? "" }
}
