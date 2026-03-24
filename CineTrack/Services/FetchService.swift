//
//  FetchService.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 02/10/25.
//

import Foundation

struct FetchService {
    private let decoder = JSONDecoder()
    
    func decodeProductionById(_ id: String) async throws -> Production {
        guard let url = URL(string: FetchConstants.url) else {
            throw FetchError.badUrlError
        }
        
        let finalUrl = url.appending(queryItems: [URLQueryItem(name: "i", value: id)])
        
        guard let (data, response) = try? await URLSession.shared.data(from: finalUrl) else {
            throw FetchError.badDataError
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponseError
        }
        
        do {
            return try decoder.decode(Production.self, from: data)
        } catch {
            print("Decoding error: \(error)")
            throw FetchError.decodingError
        }
    }
    
    func decodeProduction(title: String) async throws -> Production {
        guard let url = URL(string: FetchConstants.url) else {
            throw FetchError.badUrlError
        }
        
        let finalUrl = url.appending(queryItems: [URLQueryItem(name: "t", value: title)])
        
        guard let (data, response) = try? await URLSession.shared.data(from: finalUrl) else {
            throw FetchError.badDataError
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponseError
        }
        
        do {
            return try decoder.decode(Production.self, from: data)
        } catch {
            print("Decoding error: \(error)")
            throw FetchError.decodingError
        }
    }
    
    func decodeProductionList(searchTerm: String) async throws -> [Production] {
        guard let url = URL(string: FetchConstants.url) else {
            throw FetchError.badUrlError
        }
        
        let finalUrl = url.appending(queryItems: [URLQueryItem(name: "s", value: searchTerm)])
        
        guard let (data, response) = try? await URLSession.shared.data(from: finalUrl) else {
            throw FetchError.badResponseError
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponseError
        }
        
        do {
            return try decoder.decode(SearchResponse.self, from: data).Search.map { $0.toProduction() }
        } catch {
            print("Decoding error: \(error)")
            throw FetchError.decodingError
        }
    }
}

