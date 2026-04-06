//
//  FetchServicePackage.swift
//  NetworkComponent
//
//  Created by Ryan Davi Oliveira de Meneses on 02/04/26.
//
import Foundation

public struct FetchServicePackage {
    private let decoder = JSONDecoder()

    public init() {}

    public func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw FetchError.badDataError
        }
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw FetchError.badResponseError
        }
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Decoding error: \(error)")
            throw FetchError.decodingError
        }
    }
}
