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
                ImageLoader(url: production.poster)
                    .frame(maxWidth: .infinity)
                    .frame(height: 320)
                    .background(Color.black)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(production.title)
                        .font(.headline)
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.black.opacity(0.45))
                }
                .padding(12)
            }
            .cornerRadius(8)
        }
}

#Preview {
    CarouselItemView(production: Production(
        id: "",
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
