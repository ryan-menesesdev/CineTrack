//
//  HomeView.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 01/10/25.
//

import SwiftUI

struct HomeView: View {
    let vm: ProductionViewModel
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {    
                VStack(alignment: .center, spacing: 16) {
                        Spacer(minLength: 40)
                        
                        if let productions = vm.featuredProductions {
                            AutoScrollingCarousel(productions: productions)
                        } else {
                            ProgressView()
                                .frame(height: 400)
                        }
                        
                        ContentSectionView(label: "Series For You", productions: vm.featuredProductions ?? [])
                        
                        ContentSectionView(label: "Keep on Following", productions: vm.featuredProductions ?? [])
                        
                        ContentSectionView(label: "Recomendations for you", productions: vm.featuredProductions ?? [])
                        
                        ContentSectionView(label: "Because you've liked (NOME DE ALGUM FAVORITO)", productions: vm.featuredProductions ?? [])
                        
                        ContentSectionView(label: "Watch it again", productions: vm.featuredProductions ?? [])
                    }
            }
            .frame(maxWidth: .infinity)
            .ignoresSafeArea()
            .foregroundStyle(.white)
            .background(Color(.black))
        }
    }
}

#Preview {
    HomeView(vm: ProductionViewModel())
}
