//
//  SearchItem.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 24/03/26.
//

import Foundation

struct SearchItem: Decodable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }

    func toProduction() -> Production {
        return Production(
            id: imdbID,
            title: title,
            year: year,
            favorite: false,
            released: "",
            runtime: "",
            genre: "",
            director: nil,
            writer: nil,
            actors: "",
            plot: "",
            language: "",
            country: "",
            poster: poster,
            ratings: [],
            type: type
        )
    }
}

struct SearchResponse: Decodable {
    let Search: [SearchItem]
    let totalResults: String?
    let Response: String?
}
