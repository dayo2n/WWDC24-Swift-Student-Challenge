import SwiftUI

struct Frame7View: View {
    @Binding var selectedPageTag: Int
    @State private var typedText = ""
    private let fullText = "The variety of SF Symbols started with\n 2,300 in 2019 and now, it's over 5,000.\n\nI created this with the hope that the difficulty of\n searching and memorizing each one would be alleviated.\n\n I hope this can be helpful to designers and\n developers who found searching difficult due\n to language barriers when using SF Symbols.\n\nI also hope that this becomes an opportunity\n for iOS development beginners who are not yet\n familiar with SF Symbols to learn about them."
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
