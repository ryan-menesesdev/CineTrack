//
//  FetchError.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 02/10/25.
//

enum FetchError: Error {
    case badUrlError
    case decodingError
    case badDataError
    case badResponseError
    
    var message: String {
        switch self {
            case .badUrlError:
                "There was a problem reaching to the URL"
            case .decodingError:
                "There was a problem during decoding"
            case .badDataError:
                "There was a problem with data process"
            case .badResponseError:
                "There was a problem requesting data from URL"
        }
    }
}
