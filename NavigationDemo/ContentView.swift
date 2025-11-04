import SwiftUI

struct ContentView: View {
    var platforms: [Platform] = [
        .init(name: "Xbox", imageName: "xbox.logo", color: .green),
        .init(name: "Playstation", imageName: "playstation.logo", color: .cyan),
        .init(name: "PC", imageName: "pc", color: .purple),
        .init(name: "Mobile", imageName: "iphone", color: .red)
    ]
    
    var games: [Game] = [
        .init(name: "Minecraft", rating: "99"),
        .init(name: "God of War", rating: "98"),
        .init(name: "Fortnite", rating: "95.5"),
        .init(name: "Madden", rating: "96")
    ]
    
    @State private var paths = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $paths) {
            List {
                Section("Platforms") {
                    ForEach(platforms, id: \.name) { platform in
                        NavigationLink(value: platform) {
                            HStack {
                                Image(systemName: platform.imageName)
                                    .foregroundStyle(platform.color)
                                Text(platform.name)
                            }
                        }
                    }
                }
                
                Section("Games") {
                    ForEach(games, id: \.name) { game in
                        NavigationLink(value: game) {
                            Text(game.name)
                        }
                    }
                }
            }
            .navigationTitle("Gaming")
            
            // Platform navigation
            .navigationDestination(for: Platform.self) { platform in
                ZStack {
                    platform.color.ignoresSafeArea()
                    
                    VStack {
                        Label(platform.name, systemImage: platform.imageName)
                            .font(.largeTitle).bold()
                        
                        // Games on every platform view
                        List {
                            ForEach(games, id: \.name) { game in
                                NavigationLink(value: game) {
                                    Text(game.name)
                                }
                            }
                        }
                    }
                }
            }
            
            // Game navigation
            .navigationDestination(for: Game.self) { game in
                VStack(spacing: 20) {
                    Text("\(game.name) - \(game.rating)")
                        .font(.largeTitle).bold()
                    
                    Button("Recommended game") {
                        paths.append(games.randomElement()!)
                    }
                    
                    Button("Change platform") {
                        paths.append(platforms.randomElement()!)
                    }
                    
                    Button("Go home") {
                        paths.removeLast(paths.count)
                    }
                }
            }
        }
    }
}

struct Platform : Hashable {
    let name: String
    let imageName: String
    let color: Color
}

struct Game : Hashable {
    let name: String
    let rating: String
}

#Preview {
    ContentView()
}
