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
    let fetcher = FetchService()
    var productions: [Production]?
    
    func fetchProductionById(_ id: String) async {
        do {
            productions = [try await fetcher.decodeProduction(title: id)]
        } catch {
            switch error {
            case let fetchError as FetchError:
                print(fetchError.message)
            default:
                print("An unexpected error has occurred: \(error.localizedDescription).")
            }
        }
    }
    
    func fetchProduction(title: String) async {
        do {
            productions = [try await fetcher.decodeProduction(title: title)]
        } catch {
            switch error {
            case let fetchError as FetchError:
                print(fetchError.message)
            default:
                print("An unexpected error has occurred: \(error.localizedDescription).")
            }
        }
    }
    
    func fetchProductionList(searchTerm: String) async {
        do {
            productions = try await fetcher.decodeProductionList(searchTerm: searchTerm)
        } catch {
            switch error {
            case let fetchError as FetchError:
                print(fetchError.message)
            default:
                print("An unexpected error has occurred: \(error.localizedDescription).")
            }
        }
    }
    
}
