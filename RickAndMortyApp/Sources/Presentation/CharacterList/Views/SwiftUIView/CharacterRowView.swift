//
//  CharacterRowView.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 26/08/2025.
//

import SwiftUI

/// A reusable row view that displays a character's image, name, and species.
struct CharacterRowView: View {
    let character: RMCharacter   // The model for this row
    
    var body: some View {
        HStack(spacing: 12) {
            
            // Character image (cached + async loader)
            AsyncCachedImageView(url: URL(string: character.image))
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            // Character info (name + species)
            VStack(alignment: .leading, spacing: 4) {
                Text(character.name) // Character name
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(character.species) // Character species
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer() // Pushes content to the left
        }
        .padding()
        .background(
            // Card-like background with border
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground)) // Adaptive to dark/light mode
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        )
        .padding(.horizontal)
    }
}
