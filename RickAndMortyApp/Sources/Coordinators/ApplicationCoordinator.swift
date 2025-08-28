import UIKit

final class ApplicationCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        // Low-level API client
        let apiClient: APIClient = URLSessionAPIClient()
        
        // Service
        let service: CharactersService = CharactersServiceImpl(apiClient: apiClient)
        
        // Repository
        let repository: CharactersRepository = CharactersRepositoryImpl(service: service)
        
        // Use case
        let useCase = FetchCharactersUseCase(repository: repository)
        
        // ViewModel
        let vm = CharacterListViewModel(fetchCharactersUseCase: useCase)
        
        // ViewController
        let vc = CharacterListVC(viewModel: vm) { [weak self] character in
            self?.showDetails(for: character)
        }
        vc.title = "Characters"
        
        navigationController.setViewControllers([vc], animated: false)
    }

    private func showDetails(for character: RMCharacter) {
        // Low-level API client
        let apiClient: APIClient = URLSessionAPIClient()
        
        // Service
        let service: CharactersService = CharactersServiceImpl(apiClient: apiClient)
        
        // Repository
        let repository: CharactersRepository = CharactersRepositoryImpl(service: service)
        
        // Use case
        let useCase = FetchCharacterDetailsUseCase(repository: repository)
        
        // ViewModel
        let vm = CharacterDetailsViewModel(fetchCharacterDetailsUseCase: useCase, character: character)
        vm.loadCharacter(id: character.id)   // trigger fetch
        
        // ViewController
        let vc = CharacterDetailsViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }

}

