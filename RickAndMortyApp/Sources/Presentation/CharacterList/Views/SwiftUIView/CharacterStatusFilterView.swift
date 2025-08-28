//
//  CharacterStatusFilterView.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 26/08/2025.
//

import SwiftUI

struct CharacterStatusFilterView: View {
    let status: CharacterStatusFilter
    @Binding var selectedStatus: CharacterStatusFilter?
    
    var isSelected: Bool { status == selectedStatus }
    
    var body: some View {
        Text(status.rawValue.capitalized)
            .font(.subheadline)
            .fontWeight(isSelected ? .semibold : .regular)
            .foregroundColor(isSelected ? .white : Color(.label))
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(isSelected ? Color.purple : Color.clear)
                    .overlay(
                        Capsule()
                            .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                    )
            )
            .onTapGesture {
                selectedStatus = isSelected ? nil : status
            }
    }
}
