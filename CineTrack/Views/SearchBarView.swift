//
//  SearchBarView.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 24/03/26.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    @Binding var showSearch: Bool
    var onSearch: ((String) -> Void)? = nil
    var onCancel: (() -> Void)? = nil

    var body: some View {
        if showSearch {
            HStack(spacing: 8) {
                TextField("Search movies or series", text: $text, onCommit: {
                    onSearch?(text)
                })
                .foregroundStyle(.black)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.none)
                
                Button("Search") {
                    onSearch?(text)
                }
                
                Button {
                    onCancel?()
                } label: {
                    Image(systemName: "x.circle")
                        .foregroundStyle(.white)
                }
                .foregroundStyle(.black)
            }
            .padding(.horizontal, 4)
        }
    }
}

#Preview {
    SearchBarView(text: .constant(""), showSearch: .constant(false))
}
