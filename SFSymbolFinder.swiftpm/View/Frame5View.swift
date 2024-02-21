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
        VStack {
            HStack {
                Text("Do you know the names of everything here as well?")
                    .font(.system(size: 30))
                Spacer()
            }
            LazyVGrid(columns: Constants.columns5, spacing: 20) {
                ForEach(Constants.symbols, id: \.self) { symbolName in
                    Image(systemName: symbolName)
                        .font(.system(size: 50))
                        .padding(5)
                }
            }
            HStack {
                Text("There must have been things that didn't come to mind right away. Even if the names are intuitive, symbols with unfamiliar appearances are difficult to identify by name alone.Many designers and developers from various countries have faced challenges more than expected.\n\n**The task at hand should not be 'guessing the names of symbols,' but it's something else that requires focus.**")
                    .font(.system(size: 20))
                Spacer()
            }
            ButtonView(selectedPageTag: $selectedPageTag)
        }
        .padding(50)
    }
}
