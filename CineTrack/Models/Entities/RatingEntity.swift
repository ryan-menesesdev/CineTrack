//
//  RatingEntity.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 01/04/26.
//

import Foundation
import SwiftData

@Model
final class RatingEntity {
    var source: String
    var value: String

    init(source: String, value: String) {
        self.source = source
        self.value = value
    }

    convenience init(from rating: Rating) {
        self.init(source: rating.source, value: rating.value)
    }
    
    func toRating() -> Rating {
            Rating(source: self.source, value: self.value)
        }
}
