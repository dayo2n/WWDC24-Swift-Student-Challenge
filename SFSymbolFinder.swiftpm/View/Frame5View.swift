//
//  Frame5View.swift
//  SFSymbolFinder
//
//  Created by 제나 on 2/5/24.
//

import SwiftUI

struct Frame5View: View {
    @Binding var selectedPageTag: Int    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Do you know the names of everything here as well?")
                    .font(.system(size: 30))
                    .foregroundStyle(.white)
                Spacer()
            }
            LazyVGrid(columns: Constants.columns5, spacing: 20) {
                ForEach(Constants.symbols, id: \.self) { symbolName in
                    Image(systemName: symbolName)
                        .font(.system(size: 50))
                        .foregroundStyle(.white)
                        .padding(5)
                }
            }
            HStack {
                Text("There must have been things that didn't come to mind right away.\n\nEven if the name is intuitive, it is difficult to identify symbols with unfamiliar appearances only by name.\n\nMany designers and developers from various countries have faced challenges more than expected.\n\n**Even though what they have to do is not \"guessing the name of the symbol,\" but something else that should be focused on.**")
                    .font(.system(size: 22))
                    .foregroundStyle(.white)
                Spacer()
            }
            ButtonView(selectedPageTag: $selectedPageTag)
        }
        .padding(50)
    }
}
