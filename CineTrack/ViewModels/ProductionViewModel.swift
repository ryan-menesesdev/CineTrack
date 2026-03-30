//
//  ProductionViewModel.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 02/10/25.
//

import Foundation
import Observation

@Observable
class ProductionViewModel {
    private let fetcher = FetchService()
    var featuredProductions: [Production]?
    var searchResults: [Production]?
    var selectedProduction: Production?
    
    func fetchProductionById(_ id: String) async {
        do {
            selectedProduction = try await fetcher.decodeProductionById(id)
        } catch {
            switch error {
            case let fetchError as FetchError:
                print(fetchError.message)
            default:
                print("An unexpected error has occurred: \(error.localizedDescription).")
            }
            
            selectedProduction = nil
        }
    }
    
    func fetchProduction(title: String) async {
        do {
            selectedProduction = try await fetcher.decodeProduction(title: title)
        } catch {
            switch error {
            case let fetchError as FetchError:
                print(fetchError.message)
            default:
                print("An unexpected error has occurred: \(error.localizedDescription).")
            }
        }
    }
    
    func fetchFeaturedProductions() async {
        do {
            featuredProductions = try await fetcher.decodeProductionList(searchTerm: "pokemon") // adjust term as needed
        } catch {
            switch error {
            case let fetchError as FetchError:
                print(fetchError.message)
            default:
                print("An unexpected error has occurred: \(error.localizedDescription).")
            }
            
            featuredProductions = featuredProductions ?? []
        }
    }
    
    func fetchSearchResults(searchTerm: String) async {
        do {
            searchResults = try await fetcher.decodeProductionList(searchTerm: searchTerm)
        } catch {
            switch error {
            case let fetchError as FetchError:
                print(fetchError.message)
            default:
                print("An unexpected error has occurred: \(error.localizedDescription).")
            }
            
            searchResults = []
        }
    }
    
}
