import Foundation

public struct Production: Decodable {
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
    var ratings: [Rating]
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case id = "imdbID"
        case title = "Title"
        case year = "Year"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case poster = "Poster"
        case ratings = "Ratings"
        case type = "Type"
    }
    
    init(id: String, title: String, year: String, favorite: Bool, released: String, runtime: String, genre: String, director: String?, writer: String?, actors: String, plot: String, language: String, country: String, poster: String, ratings: [Rating], type: String) {
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
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.title = try container.decode(String.self, forKey: .title)
        self.year = try container.decode(String.self, forKey: .year)
        self.favorite = false
        self.released = try container.decode(String.self, forKey: .released)
        self.runtime = try container.decode(String.self, forKey: .runtime)
        self.genre = try container.decode(String.self, forKey: .genre)
        self.director = try container.decodeIfPresent(String.self, forKey: .director)
        self.writer = try container.decodeIfPresent(String.self, forKey: .writer)
        self.actors = try container.decode(String.self, forKey: .actors)
        self.plot = try container.decode(String.self, forKey: .plot)
        self.language = try container.decode(String.self, forKey: .language)
        self.country = try container.decode(String.self, forKey: .country)
        self.poster = try container.decode(String.self, forKey: .poster)
        self.ratings = try container.decodeIfPresent([Rating].self, forKey: .ratings) ?? []
        self.type = try container.decode(String.self, forKey: .type)
    }
}
