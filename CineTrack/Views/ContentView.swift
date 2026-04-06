import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selection = 0
    let productionViewModel = ProductionViewModel()

    var body: some View {
        TabView(selection: $selection) {
            VStack {
                HomeView(vm: productionViewModel)
            }
                .tabItem { Label("Home", systemImage: "house") }
        
            VStack {
                SearchView(vm: productionViewModel)
            }
                .tabItem { Label("Search", systemImage: "magnifyingglass") }

            VStack {
                FavoritesView(vm: productionViewModel)
            }
                .tabItem { Label("Favorites", systemImage: "heart") }
        }
        .onAppear {
            Task {
                await productionViewModel.fetchFeaturedProductions()
            }
        }
    }
}
#Preview {
    ContentView()
}
