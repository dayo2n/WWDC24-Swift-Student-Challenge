//
//  SwiftUIView.swift
//  
//
//  Created by 제나 on 2/6/24.
//

import PencilKit
import SwiftUI

struct CanvasRepresentingView: UIViewRepresentable {
    
    @Binding var isClear: Bool
    let canvas = PKCanvasView()
    @Environment(\.colorScheme) private var colorScheme
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.backgroundColor = UIColor(Color.neutral)
        let isDark = colorScheme == .dark
        canvas.tool = PKInkingTool(.pencil, color: isDark ? .black : .white, width: 20)
        return canvas
    }

    func updateUIView(_ canvas: PKCanvasView, context: Context) {
        if isClear {
            canvas.drawing = PKDrawing()
            DispatchQueue.main.async {
                isClear.toggle()
            }
        }
    }
    
    func getRenderedImage() -> UIImage {
        return canvas.drawing.image(from: canvas.bounds, scale: 1.0)
    }
}
