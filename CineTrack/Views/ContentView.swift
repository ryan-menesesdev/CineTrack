import SwiftUI
import SwiftData


struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        
        TabView {
            HomeView()
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            VStack {
                Text("Search")
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            
            VStack {
                Text("Favorites")
            }
            .tabItem {
                Label("Favorites", systemImage: "heart")
            }
        }
    }
}

#Preview {
    ContentView()
}
