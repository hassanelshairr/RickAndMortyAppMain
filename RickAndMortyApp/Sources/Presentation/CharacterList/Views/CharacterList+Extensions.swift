//
//  CharacterList+Extensions.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 26/08/2025.
//

import UIKit
import SwiftUI

// MARK: - TableView DataSource/Delegate
extension CharacterListVC: UITableViewDataSource, UITableViewDelegate {
    
    /// Number of rows = number of characters
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.characters.count
    }
    
    /// Creates a cell for each row using SwiftUI's CharacterRowView
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = viewModel.characters[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        // SwiftUI inside UIKit cell
        cell.contentConfiguration = UIHostingConfiguration {
            CharacterRowView(character: character)
        }
        
        // Trigger pagination when reaching the last cell
        viewModel.loadMoreIfNeeded(currentIndex: indexPath.row)
        
        return cell
    }
    
    /// Handles row selection -> calls onSelect callback
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelect(viewModel.characters[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /// Dynamic row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
