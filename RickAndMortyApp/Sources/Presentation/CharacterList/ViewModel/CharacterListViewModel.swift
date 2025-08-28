//
//  CharacterListViewModel.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 26/08/2025.
//

import Foundation

/// ViewModel responsible for managing the character list screen state.
/// Handles pagination, filtering by status, and communicates with the domain use case.
/// - Talks only to the UseCase (domain layer), not directly to networking.
final class CharacterListViewModel: ObservableObject {
    
    // MARK: - Dependencies
    private let fetchCharactersUseCase: FetchCharactersUseCase
    
    // MARK: - Published Properties
    /// The list of characters currently loaded.
    @Published private(set) var characters: [RMCharacter] = []
    
    /// Current filter applied to the character list.
    @Published var statusFilter: CharacterStatusFilter? = .all {
        didSet { resetAndLoad() }
    }
    
    // MARK: - Pagination State
    private(set) var currentPage: Int = 1
    private(set) var totalPages: Int = 1
    private(set) var isLoading: Bool = false
    
    // MARK: - UIKit Callbacks
    /// Callback to notify UIKit observers when state changes.
    var onChange: (() -> Void)?
    
    /// Callback to notify UIKit observers when an error occurs.
    var onError: ((Error) -> Void)?
    
    // MARK: - Init
    init(fetchCharactersUseCase: FetchCharactersUseCase) {
        self.fetchCharactersUseCase = fetchCharactersUseCase
    }
    
    // MARK: - Public Methods
    
    /// Resets pagination and reloads characters starting from page 1.
    func resetAndLoad() {
        characters = []
        currentPage = 1
        totalPages = 1
        loadMoreIfNeeded(currentIndex: 0)
    }
    
    /// Loads more characters if the user has scrolled near the end of the list.
    /// - Parameter currentIndex: The index of the currently displayed item.
    func loadMoreIfNeeded(currentIndex: Int) {
        guard !isLoading, currentPage <= totalPages else { return }
        
        // Trigger load when user reaches the *last* item or when list is empty.
        if currentIndex == characters.count - 1 || characters.isEmpty {
            isLoading = true
            fetchCharactersUseCase.execute(page: currentPage, status: statusFilter ?? .all) { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.isLoading = false
                    
                    switch result {
                    case .success(let response):
                        // Append new characters and update pagination state
                        self.characters += response.results
                        self.totalPages = response.info.pages
                        self.currentPage += 1
                        self.onChange?()
                        
                    case .failure(let error):
                        // Notify observers about the error
                        self.onError?(error)
                    }
                }
            }
        }
    }
}
