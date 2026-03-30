//
//  FavoritesView.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 24/03/26.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(\.dismiss) private var dismiss
    var liked: [Production] = []

    var body: some View {
        NavigationView {
            List {
                if liked.isEmpty {
                    VStack(alignment: .center, spacing: 8) {
                        Text("No favorites yet")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ForEach(liked.indices, id: \.self) { idx in
                        ContentListItemView(production: liked[idx])
                    }
                }
            }
            .navigationTitle("Favorites")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    FavoritesView(liked: [])
}
