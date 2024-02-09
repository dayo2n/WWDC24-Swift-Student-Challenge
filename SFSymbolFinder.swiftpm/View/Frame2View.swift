//
//  Frame2View.swift
//  SFSymbolFinder
//
//  Created by 제나 on 2/8/24.
//

import SwiftUI

struct Frame2View: View {
    @Binding var selectedPageTag: Int
    var body: some View {
        VStack {
            Image("frame2")
                .resizable()
                .scaledToFit()
            ButtonView(selectedPageTag: $selectedPageTag)
        }
        .padding(50)
    }
}
