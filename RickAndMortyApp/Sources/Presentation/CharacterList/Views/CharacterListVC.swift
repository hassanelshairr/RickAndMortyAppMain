//
//  CharacterListViewController.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 26/08/2025.
//

import UIKit
import SwiftUI
// MARK: - Character List Screen
final class CharacterListVC: UIViewController {
    
    // MARK: - UI
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var statusFilterHost: UIHostingController<CharacterStatusFilterRow>?
    
    // MARK: - Dependencies
    let viewModel: CharacterListViewModel
    let onSelect: (RMCharacter) -> Void
    
    // MARK: - Init
    init(viewModel: CharacterListViewModel, onSelect: @escaping (RMCharacter) -> Void) {
        self.viewModel = viewModel
        self.onSelect = onSelect
        super.init(nibName: nil, bundle: nil)
        self.title = "Characters"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupFilter()
        setupTable()
        bindViewModel()
        
        viewModel.resetAndLoad()
    }
    
    // MARK: - Setup Methods
    
    /// Configures table view
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CharacterCell")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Horizontal padding matches filter’s padding
        let horizontalPadding: CGFloat = 16
        
        if let filterView = statusFilterHost?.view {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: filterView.bottomAnchor, constant: 8),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -horizontalPadding),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: horizontalPadding),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }

    
    /// Configures status filter row (SwiftUI inside UIKit)
    private func setupFilter() {
        let filterRow = CharacterStatusFilterRow(viewModel: viewModel)
        let host = UIHostingController(rootView: filterRow)
        self.statusFilterHost = host
        
        guard let hostedView = host.view else { return }
        hostedView.backgroundColor = .clear
        view.addSubview(hostedView)
        hostedView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hostedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            hostedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostedView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    /// Binds view model callbacks -> updates UI or shows error
    private func bindViewModel() {
        viewModel.onChange = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.onError = { [weak self] error in
            let alert = UIAlertController(
                title: "Error",
                message: error.localizedDescription,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
}
