//
//  ContentSectionView.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 20/03/26.
//

import SwiftUI

struct ContentSectionView: View {
    var label: String
    var productions: [Production] = []
    
    var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                Text(label)
                    .font(.title2).bold()

                if productions.isEmpty {
                    ProgressView()
                        .frame(height: 120)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(productions.indices, id: \.self) { index in
                                ContentListItemView(production: productions[index])
                            }
                        }
                        .padding(.horizontal, 8)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
}

#Preview {
    ContentSectionView(
        label: "Example String 01",
        productions: [
            Production(
                title: "Banana",
                year: "2010",
                favorite: false,
                released: "14 Dec 2010",
                runtime: "4 min",
                genre: "Animation, Short, Comedy",
                director: "Kyle Balda, Samuel Tourneux",
                writer: "Pierre Coffin",
                actors: "Pierre Coffin",
                plot: "The minions chase a banana and apple around the lab.",
                language: "English",
                country: "United States, France",
                poster: "https://m.media-amazon.com/images/M/MV5BOWU4ODg3ZmUtNzRkOS00NjU2LThiZTMtNTg1NDkyMzgxYTQxXkEyXkFqcGc@._V1_SX300.jpg",
                ratings: [Rating(source: "Internet Movie Database", value: "7.3/10")],
                type: "movie"
            ),
             Production(
                title: "Banana",
                year: "2010",
                favorite: false,
                released: "14 Dec 2010",
                runtime: "4 min",
                genre: "Animation, Short, Comedy",
                director: "Kyle Balda, Samuel Tourneux",
                writer: "Pierre Coffin",
                actors: "Pierre Coffin",
                plot: "The minions chase a banana and apple around the lab.",
                language: "English",
                country: "United States, France",
                poster: "https://m.media-amazon.com/images/M/MV5BOWU4ODg3ZmUtNzRkOS00NjU2LThiZTMtNTg1NDkyMzgxYTQxXkEyXkFqcGc@._V1_SX300.jpg",
                ratings: [Rating(source: "Internet Movie Database", value: "7.3/10")],
                type: "movie"
            ),
            Production(
               title: "Banana",
               year: "2010",
               favorite: false,
               released: "14 Dec 2010",
               runtime: "4 min",
               genre: "Animation, Short, Comedy",
               director: "Kyle Balda, Samuel Tourneux",
               writer: "Pierre Coffin",
               actors: "Pierre Coffin",
               plot: "The minions chase a banana and apple around the lab.",
               language: "English",
               country: "United States, France",
               poster: "https://m.media-amazon.com/images/M/MV5BOWU4ODg3ZmUtNzRkOS00NjU2LThiZTMtNTg1NDkyMzgxYTQxXkEyXkFqcGc@._V1_SX300.jpg",
               ratings: [Rating(source: "Internet Movie Database", value: "7.3/10")],
               type: "movie"
           ),
            Production(
               title: "Banana",
               year: "2010",
               favorite: false,
               released: "14 Dec 2010",
               runtime: "4 min",
               genre: "Animation, Short, Comedy",
               director: "Kyle Balda, Samuel Tourneux",
               writer: "Pierre Coffin",
               actors: "Pierre Coffin",
               plot: "The minions chase a banana and apple around the lab.",
               language: "English",
               country: "United States, France",
               poster: "https://m.media-amazon.com/images/M/MV5BOWU4ODg3ZmUtNzRkOS00NjU2LThiZTMtNTg1NDkyMzgxYTQxXkEyXkFqcGc@._V1_SX300.jpg",
               ratings: [Rating(source: "Internet Movie Database", value: "7.3/10")],
               type: "movie"
           )
        ]
    )
}
