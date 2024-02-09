//
//  Constants.swift
//  SFSymbolFinder
//
//  Created by 제나 on 2/5/24.
//

import SwiftUI

struct Constants {
    static let columns = [
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem(),
        GridItem()
    ]
    
    static let symbols = [
        "helm", "lasso", "rays", "loupe", "swirl.circle.righthalf.filled",
        "fleuron", "skew", "glowplug", "dpad", "megaphone",
        "pano", "viewfinder", "seal", "chevron.left.forwardslash.chevron.right", "suit.club"
    ]
    
    static let minPageRange = 1
    static let maxPageRange = 6
    static let pagesNotToShow = [4]
}
