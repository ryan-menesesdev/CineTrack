import SwiftUI

struct ImageLoader: View {
    let url: String?
    var body: some View {
        KFImageLoader(url: url)
    }
}
