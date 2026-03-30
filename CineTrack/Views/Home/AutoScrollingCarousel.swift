//
//  AutoScrollingCarousel.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 19/03/26.
//

import SwiftUI

struct AutoScrollingCarousel: View {
    let productions: [Production]
    
    @State private var currentPage = 0
    
    var body: some View {
            TabView(selection: $currentPage) {
                ForEach(productions.indices, id: \.self) { index in
                    CarouselItemView(production: productions[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .scaledToFit()
            .frame(width: .infinity, height: .infinity)
            .onAppear {
                if !productions.isEmpty {
                    currentPage = min(currentPage, productions.count - 1)
                    startAutoScroll()
                }
            }
        }
    
    private func startAutoScroll() {
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            withAnimation {
                currentPage = (currentPage + 1) % 4
            }
        }
    }
}

#Preview {
    AutoScrollingCarousel(productions: [
        Production(
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
        ),
        Production(
            id: "",
            title: "Another",
            year: "2012",
            favorite: false,
            released: "01 Jan 2012",
            runtime: "5 min",
            genre: "Animation",
            director: "Director Name",
            writer: "Writer Name",
            actors: "Actor Name",
            plot: "Sample plot.",
            language: "English",
            country: "United States",
            poster: "",
            ratings: [],
            type: "short"
        )
    ])
}
