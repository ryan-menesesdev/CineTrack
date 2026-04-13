//
//  ProductionRepository.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 02/04/26.
//

import Foundation
import NetworkComponent

struct ProductionRepository: ProductionRepositoryProtocol {
    private let service = FetchServicePackage()

    func fetchById(_ id: String) async throws -> Production {
        guard let url = URL(string: FetchConstants.url)?
            .appending(queryItems: [URLQueryItem(name: "i", value: id)]) else {
            throw FetchError.badUrlError
        }
        return try await service.fetch(Production.self, from: url)
    }

    func fetchByTitle(_ title: String) async throws -> Production {
        guard let url = URL(string: FetchConstants.url)?
            .appending(queryItems: [URLQueryItem(name: "t", value: title)]) else {
            throw FetchError.badUrlError
        }
        return try await service.fetch(Production.self, from: url)
    }

    func fetchList(searchTerm: String) async throws -> [Production] {
        guard let url = URL(string: FetchConstants.url)?
            .appending(queryItems: [URLQueryItem(name: "s", value: searchTerm)]) else {
            throw FetchError.badUrlError
        }
        let response = try await service.fetch(SearchResponse.self, from: url)
        return response.Search.map { $0.toProduction() }
    }
}
