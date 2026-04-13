//
//  FavoritesRepository.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 01/04/26.
//

import SwiftData
import Foundation

final class FavoritesRepository {
    init() {}

    func isFavorited(id: String, in context: ModelContext) -> Bool {
        let fetch = FetchDescriptor<StoredProductionEntity>(
            predicate: #Predicate<StoredProductionEntity> { $0.id == id }
        )
        
        return (try? context.fetch(fetch))?.first != nil
    }

    func add(_ production: Production, in context: ModelContext) {
        let stored = StoredProductionEntity(from: production)
        context.insert(stored)
    }

    func remove(id: String, in context: ModelContext) {
        let fetch = FetchDescriptor<StoredProductionEntity>(
            predicate: #Predicate { $0.id == id }
        )
        if let existing = (try? context.fetch(fetch))?.first {
            context.delete(existing)
        }
    }

    func fetchAll(in context: ModelContext) -> [StoredProductionEntity] {
        var fetch = FetchDescriptor<StoredProductionEntity>()
        fetch.sortBy = [SortDescriptor(\.title)]
        return (try? context.fetch(fetch)) ?? []
    }
}
