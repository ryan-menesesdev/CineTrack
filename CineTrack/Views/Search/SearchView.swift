//
//  SearchView.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 01/10/25.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    let vm: ProductionViewModel

    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    VStack(alignment: .center, spacing: 16) {
                        Spacer(minLength: 40)
                        
                        VStack {
                            SearchBarView(text: $searchText, onSearch: { query in
                                Task {
                                    await vm.fetchSearchResults(searchTerm: query)
                                }
                            }, onCancel: {
                                searchText = ""
                            })
                            
                            if let productions = vm.searchResults, !productions.isEmpty {
                                VStack(spacing: 12) {
                                    ForEach(productions, id: \.id) { p in
                                        NavigationLink {
                                            ContentDetailView(vm: vm, productionId: p.id)
                                        } label: {
                                            HStack(spacing: 16) {
                                                ImageLoader(url: p.poster)
                                                    .frame(width: 80, height: 120)
                                                    .clipped()
                                                    .cornerRadius(6)
                                                
                                                VStack(alignment: .leading, spacing: 6) {
                                                    Text(p.title)
                                                        .font(.headline)
                                                        .foregroundColor(.white)
                                                    Text(p.year)
                                                        .font(.subheadline)
                                                        .foregroundColor(.gray)
                                                }
                                                
                                                Spacer()
                                            }
                                            .padding(.horizontal)
                                        }
                                        .buttonStyle(.plain)
                                        
                                        Divider()
                                            .frame(height: 1)
                                            .background(Color(.gray))
                                            .opacity(0.5)
                                            .padding(.horizontal)
                                        
                                        Spacer()
                                    }
                                }
                                .padding(.top, 8)
                                
                            } else {
                                Spacer()
                                
                                VStack(spacing: 12) {
                                    Image(systemName: "tray")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200, height: 200)
                                        .foregroundStyle(Color(.gray))
                                        .opacity(0.3)
                                    
                                    Text("Search for content you like!")
                                        .font(.title3)
                                        .foregroundColor(.gray)
                                }
                                .padding(.top, 40)
                                
                                Spacer()
                            }
                        }
                    }
                    .frame(minHeight: geo.size.height, alignment: .top)
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .ignoresSafeArea()
                .background(Color(.black))
            }
        }
    }
}

#Preview {
    SearchView(vm: ProductionViewModel())
}
