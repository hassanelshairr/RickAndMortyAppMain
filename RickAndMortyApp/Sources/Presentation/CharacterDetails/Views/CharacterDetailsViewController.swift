//
//  CharacterDetailsViewController.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 27/08/2025.
//

import UIKit
import SwiftUI

/// UIKit container for the SwiftUI `CharacterDetailsView`.
/// Handles navigation bar visibility and lifecycle integration.
final class CharacterDetailsViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: CharacterDetailsViewModel
    
    // MARK: - Init
    init(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // Embed SwiftUI View inside UIKit
        let host = UIHostingController(rootView: CharacterDetailsView(viewModel: viewModel))
        addChild(host)
        view.addSubview(host.view)
        host.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            host.view.topAnchor.constraint(equalTo: view.topAnchor),
            host.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            host.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        host.didMove(toParent: self)
    }
}
