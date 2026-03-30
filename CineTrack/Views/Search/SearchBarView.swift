//
//  SearchBarView.swift
//  CineTrack
//
//  Created by Ryan Davi Oliveira de Meneses on 24/03/26.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    var onSearch: ((String) -> Void)? = nil
    var onCancel: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: 8) {
            TextField("Search movies or series", text: $text, onCommit: {
                onSearch?(text)
            })
            .foregroundStyle(.black)
            .textFieldStyle(.roundedBorder)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.none)
            
            Button {
                onSearch?(text)
            } label: {
                Image(systemName: "magnifyingglass")
                    .imageScale(.large)
            }
            .buttonStyle(.plain)
            .padding()
            
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

#Preview {
    SearchBarView(text: .constant(""))
}
