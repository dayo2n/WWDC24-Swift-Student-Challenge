//
//  SwiftUIView.swift
//  SFSymbolFinder
//
//  Created by 제나 on 2/2/24.
//

import SwiftUI

struct ContentTransitionAnimationsView: View {
    @State private var animationIsActive = false
      private var buttonTitle: String {
          return animationIsActive ? "Stop animations" : "Start animations"
      }
    var body: some View {
        if #available(iOS 17.0, *) {
            VStack {
              VStack {
                Text("Pulse")
                Image(systemName: "wifi.router")
                  .symbolEffect(
                    .pulse,
                    isActive: animationIsActive
                  )
              }
                
              VStack {
                Text("Variable Color")
                Image(systemName: "wifi.router")
                    .symbolEffect(
                        .variableColor,
                        isActive: animationIsActive
                    )
              }
              
              VStack {
                Text("Scale")
                Image(systemName: "wifi.router")
                  .symbolEffect(
                      .scale.up,
                      isActive: animationIsActive
                  )
              }
                
              VStack {
                Text("Appear")
                Image(systemName: "wifi.router")
                  .symbolEffect(
                      .appear,
                      isActive: !animationIsActive
                  )
              }
                
              VStack {
                Text("Disappear")
                Image(systemName: "wifi.router")
                  .symbolEffect(
                      .disappear,
                      isActive: animationIsActive
                  )
              }
                
              Button(buttonTitle) {
                  animationIsActive.toggle()
              
            }
          }
        } else {
            VStack {
                
            }
        }
    }
}
#Preview {
    ContentTransitionAnimationsView()
}
