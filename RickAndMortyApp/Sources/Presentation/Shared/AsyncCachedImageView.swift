//
//  AsyncCachedImageView.swift
//  RickAndMortyApp
//
//  Created by hassan elshaer on 26/08/2025.
//

import SwiftUI

/// A SwiftUI view that tries to load and cache an image from a given URL.
/// Falls back to a placeholder if no URL is provided.
struct AsyncCachedImageView: View {
    let url: URL? // URL of the image to load
    
    var body: some View {
        Group {
            if let url = url {
                RemoteImage(url: url)
            } else {
                Rectangle()
                    .overlay(
                        Text("No Image")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    )
            }
        }
        // Apply consistent shape to whatever is shown
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

//
// MARK: - Remote Image Loader
//

/// Handles downloading the image and displaying it.
/// Uses an `@State` variable to store the loaded `UIImage`.
private struct RemoteImage: View {
    let url: URL
    
    // Holds the image once downloaded
    @State private var image: UIImage? = nil

    var body: some View {
        ZStack {
            if let img = image {
                // If image already loaded → show it
                Image(uiImage: img)
                    .resizable()
                    .scaledToFill()
            } else {
                // Show a loading spinner until the image is ready
                ProgressView()
                    .task {
                        // Asynchronously load image from cache/network
                        ImageCache.shared.load(url) { loaded in
                            self.image = loaded
                        }
                    }
            }
        }
    }
}
