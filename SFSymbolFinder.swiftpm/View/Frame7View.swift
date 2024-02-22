import SwiftUI

struct Frame7View: View {
    @Binding var selectedPageTag: Int
    @State private var typedText = ""
    private let fullText = "The variety of SF Symbols started with\n 2,300 in 2019 and now, it's over 5,000.\n\nSome people said that if they cannot find the desired symbol by search,\nthey will check all of these more than 5,000 symbols one by one.\n\nI made this with the hope that the difficulty of\nsearching and memorizing each one would be alleviated.\n\nThis is the \"SF Symbol Finder\",\nwhich will help designers and developers who have had difficulty\nsearching due to language and culture barriers when using SF symbols.\n\nI also hope that this becomes an opportunity\nfor Swift beginners who are not yet familiar\nwith SF Symbols to learn about it."
    var body: some View {
        ZStack {
            GeometryReader { geo in
                VStack {
                    Text(typedText)
                        .foregroundStyle(.white)
                        .font(.title)
                        .padding(30)
                        .onAppear {
                            _ = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
                                if typedText.count < fullText.count {
                                    typedText += String(fullText[fullText.index(fullText.startIndex, offsetBy: typedText.count)])
                                } else {
                                    timer.invalidate()
                                }
                            }
                        }
                }
            }
            .padding(.top, 200)
            VStack {
                Spacer()
                ButtonView(selectedPageTag: $selectedPageTag)
            }
        }
        .padding(50)
    }
}
