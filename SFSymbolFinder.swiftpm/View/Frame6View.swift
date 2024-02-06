//
//  Frame6View.swift
//  SFSymbolFinder
//
//  Created by 제나 on 2/5/24.
//

import SwiftUI
import CoreML
import Vision

struct Frame6View: View {
    
    @State private var isClear = false
    @Environment(\.displayScale) private var displayScale
    @State private var renderedImage = Image(systemName: "photo")
    @State private var canvasView: CanvasRepresentingView?
    
    var body: some View {
        VStack {
            HStack {
                Text("So, I created it with our capable tool, CreateML.\nThere's no need to struggle to recall relevant keywords.\nFind confusing symbols by drawing.")
                    .font(.title)
                LazyVGrid(columns: Constants.columns, spacing: 20) {
                    ForEach(Constants.symbols, id: \.self) { symbolName in
                        Image(systemName: symbolName)
                            .font(.system(size: 40))
                    }
                }
            }
            Spacer()
                .frame(height: 50)
            HStack {
                Text("⚠️ Icons composed only of letters or numbers may not be searchable.")
                Spacer()
            }
            HStack(spacing: 30) {
                ZStack {
                    canvasView
                    HStack {
                        Spacer()
                        VStack {
                            Spacer()
                            Button("CLEAR") {
                                isClear.toggle()
                            }
                            .buttonStyle(BorderedButtonStyle())
                            Button("SEARCH") {
                                if let canvasView = canvasView {
                                    let uiImage = canvasView.getRenderedImage()
                                    renderedImage = Image(uiImage: uiImage)
                                    self.canvasView = CanvasRepresentingView(isClear: $isClear)
                                } else {
                                    print("no canvas")
                                }
                            }
                            .buttonStyle(BorderedProminentButtonStyle())
                            .padding([.bottom, .trailing])
                        }
                    }
                }
                .frame(width: 400)
                .border(.red)
                VStack {
                    Spacer()
                    renderedImage
                        .scaleEffect(0.8)
                        .border(Color.red)
                    Spacer()
                }
                .frame(width: 400)
                .border(Color.black)
            }
            .frame(height: 350)
            .padding(20)
            .background(Color.primary100)
            
        }
        .padding()
        .onAppear {
            canvasView = CanvasRepresentingView(isClear: $isClear)
        }
    }
    
    // CoreML의 CIImage를 처리하고 해석하기 위한 메서드 생성, 이것은 모델의 이미지를 분류하기 위해 사용 됩니다.
    private func detect(image: CIImage) {
        // CoreML의 모델인 FlowerClassifier를 객체를 생성 후,
        // Vision 프레임워크인 VNCoreMLModel 컨터이너를 사용하여 CoreML의 model에 접근한다.
        guard let coreMLModel = try? SFSymbolClassifier(configuration: MLModelConfiguration()),
              let visionModel = try? VNCoreMLModel(for: coreMLModel.model) else {
            fatalError("Loading CoreML Model Failed")
        }
        // Vision을 이용해 이미치 처리를 요청
        let request = VNCoreMLRequest(model: visionModel) { request, error in
            guard error == nil else {
                fatalError("Failed Request")
            }
            // 식별자의 이름(꽃 이름)을 확인하기 위해 VNClassificationObservation로 변환해준다.
            guard let classification = request.results as? [VNClassificationObservation] else {
                fatalError("Faild convert VNClassificationObservation")
            }
            // 머신러닝을 통한 결과값 프린트
            print(classification)
        }
        
        // 이미지를 받아와서 perform을 요청하여 분석한다. (Vision 프레임워크)
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}
