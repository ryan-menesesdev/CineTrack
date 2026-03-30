import Kingfisher
import SwiftUI

struct KFImageLoader: View {
    let url: String?

    var body: some View {
        if let urlString = url, let imageURL = URL(string: urlString) {
            KFImage(imageURL)
                .resizable()
                .cancelOnDisappear(true)
                .placeholder {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .scaledToFit()
        } else {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray)
                .opacity(0.6)
        }
    }
}
