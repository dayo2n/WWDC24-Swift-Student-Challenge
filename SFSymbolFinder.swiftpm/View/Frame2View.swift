//
//  Frame2View.swift
//  SFSymbolFinder
//
//  Created by 제나 on 2/8/24.
//

import SwiftUI

struct Frame2View: View {
    @State private var showingCut = 0
    @State private var showingClaire = false
    @State private var typedText = ""
    private let fullText = "setting"
    @Binding var selectedPageTag: Int
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Episode #2")
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
                            .onAppear(perform: showingNextCutAfter3Seconds)
                        VStack {
                            Spacer()
                            HStack {
                                Image(Constants.frame2_1)
                                    .resizable()
                                    .scaledToFit()
                                Spacer()
                            }
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
                        HStack {
                            VStack {
                                Spacer()
                                Image(Constants.frame2_2)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: Constants.frameWidth * 0.6)
                            }
                            Spacer()
                        }
                        if showingClaire {
                            HStack {
                                Spacer()
                                VStack {
                                    Spacer()
                                    Image(Constants.frame2_3)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: Constants.frameWidth * 0.6)
                                }
                            }
                            .onAppear(perform: showingNextCutAfter3Seconds)
                        }
                        
                        VStack {
                            HStack {
                                Text("Zena: I could have just used SF Symbols.\nWhy did you draw it?")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundStyle(.black.opacity(0.3))
                                    )
                                Spacer()
                            }
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    withAnimation(.easeIn) {
                                        showingClaire = true
                                    }
                                }
                            }
                            if showingClaire {
                                HStack {
                                    Spacer()
                                    Text("Claire: I looked it up, but I couldn't find that symbol. So I thought it wasn't provided by SF Symbols.")
                                        .font(.title3)
                                        .foregroundStyle(.white)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .foregroundStyle(.black.opacity(0.3))
                                        )
                                }
                            }
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
                            Image(Constants.frame2_4)
                                .resizable()
                                .scaledToFit()
                        }
                        VStack {
                            Text("Zena: Take a look at this.")
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
                            .onAppear(perform: showingNextCutAfter1Seconds)
                        VStack {
                            Spacer()
                            Image(Constants.frame2_5)
                                .resizable()
                                .scaledToFit()
                        }
                        
                        VStack {
                            Text("Claire: Ah... I didn't know that's called a grid.")
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
            if showingCut >= 5 {
                ButtonView(selectedPageTag: $selectedPageTag)
            }
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
    
    private func showingNextCutAfter6Seconds() {
        if showingCut == 5 { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            withAnimation(.easeIn) {
                self.showingCut += 1
            }   
        }
    }
}
