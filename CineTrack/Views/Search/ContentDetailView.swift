//
//  ContentDetailView.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 24/03/26.
//

import SwiftUI

struct ContentDetailView: View {
    let vm: ProductionViewModel
    let productionId: String
    @State var isLiked = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let detail = vm.selectedProduction {
                    ImageLoader(url: detail.poster)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                        .cornerRadius(8)
                    
                    Spacer()
                    
                    HStack {
                        Text(detail.title)
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                        Button {
                            isLiked.toggle()
                        } label: {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .resizable()
                                .foregroundStyle(isLiked ? Color(.red) : Color(.white))
                                .frame(width: 35, height: 30)
                        }
                    }
                    
                    
                    Text("\(detail.year) \(detail.type.capitalized)")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text(detail.genre)
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text(detail.plot)
                        .font(.body)
                        .padding(.top, 8)
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity, minHeight: 200)
                }
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .foregroundStyle(.white)
        .background(Color(.black))
        .task {
            await vm.fetchProductionById(productionId)
        }
    }
}

#Preview {
    ContentDetailView(vm: ProductionViewModel(), productionId: "tt8515016")
}
