//
//  Frame1View.swift
//  SFSymbolFinder
//
//  Created by 제나 on 2/8/24.
//

import SwiftUI

struct Frame1View: View {
    @State private var showingCut = 0
    @State private var typedEffectCount = 0
    @State private var typedText = ""
    private let fullText = "setting"
    @Binding var selectedPageTag: Int
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            HStack {
                Text("Episode #1")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .bold()
                    .onAppear(perform: showingNextCutAfter1Seconds)
                Spacer()
            }
            HStack(spacing: 20) {
                /* Cut #1 */
                ZStack {
                    if showingCut >= 1 {
                        Rectangle()
                            .stroke(.white, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                            .onAppear(perform: showingNextCutAfter4Seconds)
                        VStack {
                            Image(Constants.frame1_2)
                                .resizable()
                                .scaledToFit()
                                .frame(width: Constants.frameWidth - 200)
                            HStack {
                                Spacer()
                                Image(Constants.frame1_1)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: Constants.frameWidth - 100)
                            }
                        }
                        HStack {
                            Text("The girl who is curious about the name of symbol is Zena.\n\nShe is ...\n1. Swift beginner\n2. Korean(**BAD** at English)")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .frame(width: Constants.frameWidth * 0.6)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(.black.opacity(0.4))
                                )
                                .padding(.leading)
                                .padding(.top, 150)
                            Spacer()
                        }
                    }
                }
                .frame(
                    width: Constants.frameWidth, 
                    height: Constants.frameHeight
                )
                
                /* Cut #2 */
                ZStack {
                    if showingCut >= 2 {
                        Rectangle()
                            .stroke(.white, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                            .onAppear(perform: showingNextCutAfter3Seconds)
                        VStack {
                            Spacer()
                            Image(Constants.frame1_3)
                                .resizable()
                                .scaledToFit()
                                .overlay {
                                    HStack {
                                        Text(typedText)
                                            .font(.title3)
                                            .foregroundStyle(.white)
                                            .bold()
                                            .padding(.leading, 340)
                                            .padding(.bottom, 127)
                                        Spacer()
                                    }
                                }
                                .onAppear {
                                    _ = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
                                        if typedText.count < fullText.count {
                                            typedText += String(fullText[fullText.index(fullText.startIndex, offsetBy: typedText.count)])
                                        } else {
                                            timer.invalidate()
                                        }
                                    }
                                }
                        }
                        
                        VStack {
                            Text("She thought she could find it by searching \"setting\" in the SF Symbols.")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(.black.opacity(0.3))
                                )
                            Spacer()
                        }
                        .padding()
                    }
                }
                .frame(
                    width: Constants.frameWidth, 
                    height: Constants.frameHeight
                )
            }
            HStack(spacing: 20) {
                /* Cut #3 */
                ZStack {
                    if showingCut >= 3 {
                        Rectangle()
                            .stroke(.white, lineWidth: 1.0)
                            .onAppear(perform: showingNextCutAfter3Seconds)
                        VStack {
                            Spacer()
                            Image(Constants.frame1_4)
                                .resizable()
                                .scaledToFit()
                        }
                        VStack {
                            Text("But she couldn't get any search results.")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(.black.opacity(0.3))
                                )
                            Spacer()
                        }
                        .padding()
                    }                    
                }
                .frame(
                    width: Constants.frameWidth, 
                    height: Constants.frameHeight
                )
                
                /* Cut #4 */
                ZStack {
                    if showingCut >= 4 {
                        Rectangle()
                            .stroke(.white, lineWidth: 1.0)
                            .onAppear(perform: showingNextCutAfter4Seconds)
                            .onAppear(perform: typingEffect)
                        VStack {
                            HStack(spacing: 10) {
                                if typedEffectCount >= 1 {
                                    Image(Constants.frame1_6)
                                        .onAppear(perform: typingEffect)
                                }
                                if typedEffectCount >= 2 {
                                    Image(Constants.frame1_6)
                                        .onAppear(perform: typingEffect)
                                }
                                if typedEffectCount >= 3 {
                                    Image(Constants.frame1_7)
                                }
                                Spacer()
                            }
                            .padding(.leading, 150)
                            Spacer()
                        }
                        VStack {
                            Spacer()
                            Image(Constants.frame1_5)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
                .frame(
                    width: Constants.frameWidth, 
                    height: Constants.frameHeight
                )
            }
            if showingCut >= 5 {
                ButtonView(selectedPageTag: $selectedPageTag)
            }
            Spacer()
        }
        .padding(50)
    }
    
    private func showingNextCutAfter1Seconds() {
        if showingCut == 5 { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeIn) {
                self.showingCut += 1
            }   
        }
    }
    
    private func showingNextCutAfter3Seconds() {
        if showingCut == 5 { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation(.easeIn) {
                self.showingCut += 1
            }  
        } 
    }
    
    private func showingNextCutAfter4Seconds() {
        if showingCut == 5 { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            withAnimation(.easeIn) {
                self.showingCut += 1
            }   
        }
    }
    
    private func typingEffect() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeIn) {
                typedEffectCount += 1
            }
        }
    }
}
