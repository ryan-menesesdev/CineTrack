//
//  ProductionRepositoryProtocol.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 02/04/26.
//

protocol ProductionRepositoryProtocol {
    func fetchById(_ id: String) async throws -> Production
    func fetchByTitle(_ title: String) async throws -> Production
    func fetchList(searchTerm: String) async throws -> [Production]
}
