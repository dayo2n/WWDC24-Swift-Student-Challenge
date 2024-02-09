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
    @Binding var selectedPageTag: Int    
    @State private var isClear = false
    @Environment(\.displayScale) private var displayScale
    @State private var results = ""
    @State private var canvasView: CanvasRepresentingView?
    @Environment(\.undoManager) var undoManager
    
    var body: some View {
        VStack {
            Button("") {
                undoManager?.undo()
            }.keyboardShortcut("z", modifiers: .command)
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
                                    predict(image: CIImage(image: uiImage)!)
                                } else {
                                    print("no canvas")
                                }
                            }
                            .buttonStyle(BorderedProminentButtonStyle())
                            .padding([.bottom, .trailing])
                        }
                    }
                }
                VStack {
                    Spacer()
                    Text(results)
                        .font(.footnote)
                        .foregroundStyle(.white)
                        .padding()
                    Spacer()
                }
                .border(Color.black)
            }
            .frame(height: 450)
            .padding(20)
            .background(Color.primary100)

            ButtonView(selectedPageTag: $selectedPageTag)
        }
        .padding(50)
        .onAppear {
            canvasView = CanvasRepresentingView(isClear: $isClear)
        }
    }
    
    private func predict(image: CIImage) {
        guard let coreMLModel = try? SFSymbolClassifier(configuration: MLModelConfiguration()),
              let visionModel = try? VNCoreMLModel(for: coreMLModel.model) else {
            fatalError("Loading CoreML Model Failed")
        }
        // Vision을 이용해 이미치 처리를 요청
        let request = VNCoreMLRequest(model: visionModel) { request, error in
            guard error == nil else {
                fatalError("Failed Request")
            }
            // 식별자의 이름을 확인하기 위해 VNClassificationObservation로 변환해준다.
            guard let classification = request.results as? [VNClassificationObservation] else {
                fatalError("Faild convert VNClassificationObservation")
            }
            // 머신러닝을 통한 결과값 프린트
            let sortedClassification = classification.sorted(by: { $0.confidence > $1.confidence })
            var count = 0
            self.results = ""
            for result in sortedClassification {
                if count == 5 { break }
                self.results += "\(result.identifier) \(result.confidence)\n"
                count += 1
            }
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
