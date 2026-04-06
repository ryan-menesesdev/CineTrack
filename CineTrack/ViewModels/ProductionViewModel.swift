//
//  ProductionViewModel.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 02/10/25.
//

import Foundation
import Observation
import NetworkComponent

@Observable
class ProductionViewModel {
    private let repository: ProductionRepositoryProtocol
    var featuredProductions: [Production]?
    var searchResults: [Production]?
    var selectedProduction: Production?
    
    init(repository: ProductionRepositoryProtocol = ProductionRepository()) {
        self.repository = repository
    }
    
    func fetchProductionById(_ id: String) async {
        do {
            selectedProduction = try await repository.fetchById(id)
        }
        catch {
            handle(error); selectedProduction = nil
        }
    }
    
    func fetchFeaturedProductions() async {
        do {
            featuredProductions = try await repository.fetchList(searchTerm: "pokemon")
        }
        catch {
            handle(error); featuredProductions = featuredProductions ?? []
        }
    }
    
    func fetchSearchResults(searchTerm: String) async {
        do {
            searchResults = try await repository.fetchList(searchTerm: searchTerm)
        }
        catch {
            handle(error); searchResults = []
        }
    }

    private func handle(_ error: Error) {
        if let fetchError = error as? FetchError {
            print(fetchError.message)
        } else {
            print("Unexpected error: \(error.localizedDescription)")
        }
    }
    
}
