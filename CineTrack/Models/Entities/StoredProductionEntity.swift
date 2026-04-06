//
//  StoredProduction.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 01/04/26.
//

import SwiftData

@Model
final class StoredProductionEntity {
    var id: String
    var title: String
    var year: String
    var favorite: Bool
    var released: String
    var runtime: String
    var genre: String
    var director: String?
    var writer: String?
    var actors: String
    var plot: String
    var language: String
    var country: String
    var poster: String
    var ratings: [RatingEntity]
    var type: String

    init(
        id: String,
        title: String,
        year: String,
        favorite: Bool = true,
        released: String,
        runtime: String,
        genre: String,
        director: String?,
        writer: String?,
        actors: String,
        plot: String,
        language: String,
        country: String,
        poster: String,
        ratings: [RatingEntity],
        type: String
    ) {
        self.id = id
        self.title = title
        self.year = year
        self.favorite = favorite
        self.released = released
        self.runtime = runtime
        self.genre = genre
        self.director = director
        self.writer = writer
        self.actors = actors
        self.plot = plot
        self.language = language
        self.country = country
        self.poster = poster
        self.ratings = ratings
        self.type = type
    }

    convenience init(from production: Production) {
        let ratingEntities = production.ratings.map { RatingEntity(from: $0) }
        self.init(
            id: production.id,
            title: production.title,
            year: production.year,
            favorite: true,
            released: production.released,
            runtime: production.runtime,
            genre: production.genre,
            director: production.director,
            writer: production.writer,
            actors: production.actors,
            plot: production.plot,
            language: production.language,
            country: production.country,
            poster: production.poster,
            ratings: ratingEntities,
            type: production.type
        )
    }
    
    func toProduction() -> Production {
            Production(
                id: self.id,
                title: self.title,
                year: self.year,
                favorite: self.favorite,
                released: self.released,
                runtime: self.runtime,
                genre: self.genre,
                director: self.director,
                writer: self.writer,
                actors: self.actors,
                plot: self.plot,
                language: self.language,
                country: self.country,
                poster: self.poster,
                ratings: self.ratings.map { $0.toRating() },
                type: self.type
            )
        }
}
