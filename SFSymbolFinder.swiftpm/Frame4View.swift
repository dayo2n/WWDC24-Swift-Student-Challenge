//
//  Frame4View.swift
//  SFSymbolFinder
//
//  Created by 제나 on 2/1/24.
//

import SwiftUI

struct Frame4View: View {
    
    @State private var showResult = false
    @State private var isAnwerCorrect = false
    @State private var isAnimationActive = false
    private var headlineIconName: String {
        isAnwerCorrect ? "party.popper" : "cloud.bolt.rain"
    }
    private var titleLabel: String {
        isAnwerCorrect ? "It's amazing, that's the correct answer!" : "It was close! The correct answer is 'bolt.'"
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 50) {
                HStack {
                    Text("I'll give you a quiz, would you like to try and solve it?\nTry to guess the name of the symbol below among the three options.")
                        .font(.system(size: 30))
                    Spacer()
                }
                Image(systemName: "bolt")
                    .font(.system(size: 200))
                HStack(spacing: 50) {
                    Button("thunder") {
                        showResult = true
                        isAnwerCorrect = false
                    }
                    .buttonStyle(OptionButtonStyle())
                    Button("bolt") {
                        showResult = true
                        isAnwerCorrect = true
                    }
                    .buttonStyle(OptionButtonStyle())
                    Button("lightning") {
                        showResult = true
                        isAnwerCorrect = false
                    }
                    .buttonStyle(OptionButtonStyle())
                }
            }
            .padding(50)
            
            if showResult {
                Color.black
                    .opacity(0.8)
                    .ignoresSafeArea()
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 593, height: 331)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                .primary50,
                                .primary100,
                                .primary300,
                                .primary500
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay {
                        VStack(spacing: 20) {
                            if #available(iOS 17.0, *) {
                                Button {
                                } label: {
                                    Image(systemName: headlineIconName)
                                        .foregroundStyle(.black)
                                        .font(.system(size: 70))
                                }
                                .disabled(true)
                                .symbolEffect(
                                    .bounce.down, 
                                    options: .repeating.speed(0.5),
                                    value: isAnimationActive
                                )        
                                .onAppear {
                                    isAnimationActive = true
                                }
                            } else {
                                // Fallback on earlier versions
                                Image(systemName: headlineIconName)
                                    .foregroundStyle(.black)
                                    .font(.system(size: 50))
                            }
                            Text(titleLabel)
                                .font(.system(size: 25))
                            Text("Unfortunately, you won't find this symbol by searching for **'thunder'** or **'lightning.'**")
                                .font(.system(size: 25))
                        }
                        .padding(.horizontal, 26)
                    }
            }
        }
    }
    
    struct OptionButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration
                .label
                .font(.title)
                .foregroundStyle(Color.white)
                .padding(.horizontal, 100)
                .padding(.vertical, 50)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.primary500)
                        .frame(width: 200, height: 116)
                        .shadow(radius: 4, y: 4)
                )
        }
    }
}

#Preview {
    Frame4View()
}
