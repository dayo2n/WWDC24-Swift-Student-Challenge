import SwiftUI

struct ContentView: View {
    @State private var selectedPage = 6
    var body: some View {
        TabView(selection: $selectedPage){
            Frame1View(selectedPageTag: $selectedPage)
                .tag(1)
            Frame2View(selectedPageTag: $selectedPage)
                .tag(2)
            Frame3View(selectedPageTag: $selectedPage)
                .tag(3)
            Frame4View(selectedPageTag: $selectedPage)
                .tag(4)
            Frame5View(selectedPageTag: $selectedPage)
                .tag(5)
            Frame6View(selectedPageTag: $selectedPage)
                .tag(6)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}
