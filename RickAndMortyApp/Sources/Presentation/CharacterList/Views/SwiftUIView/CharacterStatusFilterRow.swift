//
//  CharacterStatusFilterRow.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 26/08/2025.
//

import SwiftUI

struct CharacterStatusFilterRow: View {
    @ObservedObject var viewModel: CharacterListViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(CharacterStatusFilter.allCases.filter { $0 != .all }, id: \.self) { status in
                    CharacterStatusFilterView(
                        status: status,
                        selectedStatus: $viewModel.statusFilter
                    )
                }
            }
            .padding(.horizontal)
        }
    }
}
