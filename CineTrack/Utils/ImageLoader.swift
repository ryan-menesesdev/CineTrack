import SwiftUI

struct ImageLoader: View {
    var url: String
    
    var body: some View {
        KFImageLoader(url: url)
    }
}

