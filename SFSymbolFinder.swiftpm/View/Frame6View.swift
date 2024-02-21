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
    
    struct Result: Hashable {
        let label: String
        let confidence: Int
    }
    @Binding var selectedPageTag: Int
    @State private var isClear = false
    @Environment(\.displayScale) private var displayScale
    @State private var canvasView: CanvasRepresentingView?
    @Environment(\.undoManager) var undoManager
    @State private var results = [Result]()
    
    var body: some View {
        VStack {
            Button("") {
                undoManager?.undo()
            }.keyboardShortcut("z", modifiers: .command)
            HStack {
                Text("So, I created it with our capable tool, CreateML.\nThere's no need to struggle to recall relevant keywords.\nFind confusing symbols by drawing.")
                    .font(.title)
                LazyVGrid(columns: Constants.columns5, spacing: 20) {
                    ForEach(Constants.symbols, id: \.self) { symbolName in
                        Image(systemName: symbolName)
                            .font(.system(size: 40))
                    }
                }
            }
            Spacer()
                .frame(height: 50)
            HStack {
                Text("⚠️ Icons including letters or numbers may not be searchable.")
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
                                    #warning("강제언래핑 치워")
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
                NavigationStack {
                    VStack {
                        Text("You can search with the keyword below\nPress the button to see if there's a symbol you're looking for")
                            .multilineTextAlignment(.center)
                            .font(.subheadline)
                            .foregroundStyle(Color.primary100)
                            .padding()
                        Spacer()
                        ForEach(results, id: \.self) { result in
                            NavigationLink {
                                SFSymbolsView(keyword: result.label)
                                    .navigationTitle(result.label)
                            } label: {
                                VStack(spacing: 2) {
                                    Text("\(result.label)")
                                        .font(.callout)
                                        .bold()
                                        .foregroundStyle(.white)
                                    Text("confidence **\(result.confidence)**%")
                                        .font(.callout)
                                        .foregroundStyle(.white.opacity(0.8))
                                }
                                .frame(width: 250)
                            }
                            .padding(2)
                            .buttonStyle(BorderedButtonStyle())

                        }
                        Spacer()
                    }
                    .padding()
                }
                .frame(width: 450)
            }
            .frame(height: 500)
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
            self.results = []
            for result in sortedClassification {
                print(result)
                if count == 5 { break }
                let confidence = Int(result.confidence * 100)
                self.results.append(Result(
                    label: result.identifier,
                    confidence: confidence
                ))
                count += 1
            }
            self.results.sort(by: { $0.confidence > $1.confidence})
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

struct SFSymbolsView: View {
    let keyword: String
    private var systemNames: [String] {
        let keyword = keyword.replacingOccurrences(of: "_", with: ".")
        return Constants.sfsymbols.filter({ $0.contains(keyword)})
    }
    var body: some View {
        ScrollView {
            VStack {
                Text("Click to copy the name to the clipboard")
                    .font(.subheadline)
                    .foregroundStyle(Color.primary100)
                LazyVGrid(columns: Constants.column1) {
                    ForEach(systemNames, id: \.self) { systemName in
                        HStack(spacing: 10) {
                            Image(systemName: systemName)
                                .font(.largeTitle)
                                .padding()
                                .foregroundStyle(.white)
                                .frame(width: 80)
                            Text(systemName)
                                .font(.title3)
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        .border(Color.primary100, width: 0.5)
                    }
                }
            }
            .padding()
            .padding(.top, 40)
        }
    }
}
