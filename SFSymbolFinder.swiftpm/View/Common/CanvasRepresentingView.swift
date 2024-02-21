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
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.backgroundColor = UIColor(Color(hex: 0x191919))
        canvas.tool = PKInkingTool(.pencil, color: .black, width: 20)
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
