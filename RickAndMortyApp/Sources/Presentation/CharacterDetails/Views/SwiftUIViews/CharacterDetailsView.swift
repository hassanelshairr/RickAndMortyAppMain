//
//  CharacterDetailsView.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 26/08/2025.
//

import SwiftUI

/// SwiftUI View that displays the details of a character.
/// Uses the `CharacterDetailsViewModel` to get data and handle logic.
struct CharacterDetailsView: View {
    
    // MARK: - Properties
    let viewModel: CharacterDetailsViewModel
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Status Badge Color
    /// Dynamic color depending on character's status
    var statusColor: Color {
        switch viewModel.status.lowercased() {
        case "alive":
            return .green
        case "dead":
            return .red
        default:
            return .gray
        }
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                
                // MARK: Header Image + Back Button
                ZStack(alignment: .topLeading) {
                    AsyncCachedImageView(url: viewModel.imageURL)
                        .frame(height: 300)
                        .frame(maxWidth: .infinity)
                        .clipShape(
                            RoundedCorner(
                                radius: 24,
                                corners: [.topLeft, .topRight, .bottomLeft, .bottomRight]
                            )
                        )
                        .edgesIgnoringSafeArea(.top)
                    
                    // Back button
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.purple)
                            .font(.system(size: 18, weight: .semibold))
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    .padding(.top, 50)
                    .padding(.leading, 16)
                }
                
                // MARK: Character Info Section
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Name + Species/Gender + Status Badge
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(viewModel.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text("\(viewModel.species) • \(viewModel.gender)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Text(viewModel.status)
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(statusColor)
                            .clipShape(Capsule())
                    }
                    
                    // Location Row
                    HStack {
                        Text("Location:")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text(viewModel.location)
                            .foregroundColor(.primary)
                    }
                    .font(.body)
                    
                    Spacer(minLength: 40)
                }
                .padding(20)
                
                Spacer()
            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }
}
