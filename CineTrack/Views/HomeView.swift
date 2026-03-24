//
//  HomeView.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 01/10/25.
//

import SwiftUI

struct HomeView: View {
    let vm = ProductionViewModel()
    @State var searchTerm = ""
    @State var showSearch = false
    @State var showFavorites = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {    
                VStack(alignment: .center, spacing: 16) {
                        Spacer(minLength: 40)
                        
                        HeaderView(
                            showSearch: $showSearch,
                            searchText: $searchTerm,
                            showFavorites: $showFavorites,
                            likedProductions: []
                        )
                        
                        if let productions = vm.productions {
                            AutoScrollingCarousel(productions: productions)
                        } else {
                            ProgressView()
                                .frame(height: 400)
                        }
                        
                        ContentSectionView(label: "Series For You", productions: vm.productions ?? [])
                        
                        ContentSectionView(label: "Keep on Following", productions: vm.productions ?? [])
                        
                        ContentSectionView(label: "Recomendations for you", productions: vm.productions ?? [])
                        
                        ContentSectionView(label: "Because you've liked (NOME DE ALGUM FAVORITO)", productions: vm.productions ?? [])
                        
                        ContentSectionView(label: "Watch it again", productions: vm.productions ?? [])
                    }
            }
            .frame(maxWidth: .infinity)
            .ignoresSafeArea()
            .foregroundStyle(.white)
            .background(Color(.black))
        }
        .onAppear {
            Task {
                await vm.fetchProductionList(searchTerm: "banana")
            }
        }
    }
}

#Preview {
    HomeView()
}
