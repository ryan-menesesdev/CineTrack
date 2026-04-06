//
//  ContentDetailViewModel.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 01/04/26.
//

import Foundation
import SwiftUI
import SwiftData

final class ContentDetailViewModel: ObservableObject {
    @Published var isLiked: Bool = false

    private let repo: FavoritesRepository

    init(repo: FavoritesRepository = .init()) {
        self.repo = repo
    }

    func setInitialLikeState(for production: Production, in context: ModelContext) {
        isLiked = repo.isFavorited(id: production.id, in: context)
    }

    func toggleFavorite(_ production: Production, in context: ModelContext) {
        if repo.isFavorited(id: production.id, in: context) {
            repo.remove(id: production.id, in: context)
            isLiked = false
        } else {
            repo.add(production, in: context)
            isLiked = true
        }
    }
}
