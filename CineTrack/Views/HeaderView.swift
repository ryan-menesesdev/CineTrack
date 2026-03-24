//
//  HeaderView.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 24/03/26.
//

import SwiftUI

struct HeaderView: View {
    @Binding var showSearch: Bool
    @Binding var searchText: String
    @Binding var showFavorites: Bool

    var likedProductions: [Production] = []

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Button {
                    withAnimation { showSearch.toggle() }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                }
                .buttonStyle(.plain)
                .padding()
                
                Button {
                    showFavorites.toggle()
                } label: {
                    Image(systemName: "heart")
                        .imageScale(.large)
                }
                .buttonStyle(.plain)
                .padding()
                
                Spacer()
                
                SearchBarView(text: $searchText, showSearch: $showSearch , onSearch: { query in
                    print("Search requested: \(query)")
                }, onCancel: {
                    withAnimation {
                        searchText = ""
                        showSearch = false
                    }
                })
                .transition(.move(edge: .top).combined(with: .opacity))
            }

        }
        .padding()
        .sheet(isPresented: $showFavorites) {
            FavoritesView(liked: likedProductions)
        }
    }
}

#Preview {
    HeaderView(showSearch: .constant(false), searchText: .constant(""), showFavorites: .constant(false), likedProductions: [])
}
