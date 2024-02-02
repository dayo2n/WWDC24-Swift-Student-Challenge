//
//  Color+Extension.swift
//  SFSymbolFinder
//
//  Created by 제나 on 2/1/24.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
            let red = Double((hex >> 16) & 0xff) / 255.0
            let green = Double((hex >> 8) & 0xff) / 255.0
            let blue = Double(hex & 0xff) / 255.0
            self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
    static let primary50 = Color(hex: 0xE2CAFF)
    static let primary100 = Color(hex: 0xCFA8FF)
    static let primary300 = Color(hex: 0xB77DFF)
    static let primary500 = Color(hex: 0x9F51FF)
}
