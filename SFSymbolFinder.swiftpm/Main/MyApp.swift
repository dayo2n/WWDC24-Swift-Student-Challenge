import SwiftUI

@main
struct MyApp: App {
    @State private var page = 1
    var body: some Scene {
        WindowGroup {
            ContentView()
                .background(Color.neutral)
        }
    }
}
