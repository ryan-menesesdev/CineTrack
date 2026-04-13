//
//  FavoritesView.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 24/03/26.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Query(sort: \StoredProductionEntity.title) private var favorites: [StoredProductionEntity]
    
    let vm: ProductionViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if favorites.isEmpty {
                    ContentUnavailableView("No Favorites",
                                           systemImage: "heart",
                                           description: Text("Your favorite productions will appear here."))
                    .foregroundStyle(.white)
                } else {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
                        ForEach(favorites) { favorite in
                            NavigationLink {
                                ContentDetailView(vm: vm, productionId: nil, preloadedProduction: favorite.toProduction())
                            } label: {
                                VStack {
                                    ImageLoader(url: favorite.poster)
                                        .aspectRatio(2/3, contentMode: .fit)
                                        .cornerRadius(8)
                                    Text(favorite.title)
                                        .font(.caption)
                                        .lineLimit(1)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Favorites")
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(Color.black)
        }
    }
}

#Preview {
    FavoritesView(vm: ProductionViewModel())
}
