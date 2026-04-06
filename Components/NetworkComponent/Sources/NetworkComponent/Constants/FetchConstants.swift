//
//  FetchContants.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 02/10/25.
//

import Foundation

enum FetchConstants {
    private static let key: String = ProcessInfo.processInfo.environment["OMDB_API_KEY"] ?? "No value for API Key"
    static let url = "https://www.omdbapi.com/?apikey=\(key)"
    
}
