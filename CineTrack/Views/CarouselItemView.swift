//
//  CarouselItemView.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 19/03/26.
//

import SwiftUI

struct CarouselItemView: View {
    let production: Production

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: production.poster)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } placeholder: {
                Color.gray
            }

            VStack {
                Text(production.title)
                    .font(.headline)
                    .lineLimit(2)
            }
            .padding()
            .background(Color.black.opacity(0.6))
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CarouselItemView(production: Production(
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
    ))
}
