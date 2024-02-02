//
//  Frame3.swift
//  SFSymbolFinder
//
//  Created by 제나 on 2/1/24.
//

import SwiftUI

struct Frame3View: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("SF Symbols")
                            .font(.system(size: 100))
                        Divider()
                            .padding()
                        Text("SF Symbol is set of symbol images created by Apple that you can use as icons in yours app. How can I use it? Just one line of code.")
                            .font(.system(size: 30))
                        CodeBlockView()
                        Text("Is it familiar? It's the code you see every time you create a new file in SwiftUI.\nIn SF Symbols, the symbols are intuitively named.")
                            .font(.system(size: 30))
                    }
                    Spacer()
                }
                Divider()
                    .padding()
                ExplanationBoxView(
                    systemName: "square.and.arrow.up",
                    explanation: "A square with an arrow pointing upwards, correct? In that case, the name of this symbol is \"square.and.arrow.up\".\n It is commonly used in apps to represent the concept of sharing, and you may also search for it as \"share\"."
                )
                ExplanationBoxView(
                    systemName: "gear",
                    explanation: "Then why didn't it show up when you searched for 'setting' earlier? Actually, if you had entered 'settings,' you could have found it. It's just a mishap caused by unfamiliarity with English expressions.\nAs for this symbol, it's called 'gear,' just like its appearance."
                )
                ExplanationBoxView(
                    systemName: "thermometer.sun",
                    explanation: "Now you can figure it out easily, right?\nThis symbol with a thermometer and sun together, read in order.\nThis symbol is \"thermometer.sun\"!"
                )
            }
            .padding(50)
        }
    }
}

struct CodeBlockView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                windowButton(Color.red)
                windowButton(Color.yellow)
                windowButton(Color.green)
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.top, 15)
            .padding(.bottom, 10)
            .frame(height: 50)
            .background(
                Rectangle()
                    .foregroundStyle(Color(hex: 0x191919).opacity(0.6))
            )
            Text("Image(systemName: “globe”)")
                .font(.custom("Menlo-Regular", size: 40))
                .padding(.vertical, 50)
                .padding(.leading, 30)
                .foregroundStyle(Color.white)
        }
        .background(Color(hex: 0x343444))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    func windowButton(_ color: Color) -> some View {
        Circle()
            .frame(width: 20)
            .foregroundStyle(color)
    }
}

struct ExplanationBoxView: View {
    let systemName: String
    let explanation: String
    var body: some View {
        HStack(spacing: 30) {
            Spacer()
            Image(systemName: systemName)
                .font(.system(size: 200))
                .frame(width: 200)
            Spacer()
            Text(explanation)
                .font(.system(size: 30))
            Spacer()
        }
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color.primary50)
        )
    }
}

#Preview {
    Frame3View()
}
