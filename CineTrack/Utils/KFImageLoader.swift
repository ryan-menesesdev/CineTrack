import Kingfisher
import SwiftUI

struct KFImageLoader: View {
    var url: String
    
    var body: some View {
        KFImage(URL(string: url)!)
    }
}
