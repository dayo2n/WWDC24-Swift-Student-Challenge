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
    @State private var canvasView: CanvasRepresentingView?
    @Environment(\.undoManager) var undoManager
    @State private var results = [Result]()
    @State private var isNavigate = false
    @State private var selectedLabel = ""
    @State private var showErrorAlert = false
    
    var body: some View {
        ZStack {
            VStack {
                Button("") {
                    undoManager?.undo()
                }.keyboardShortcut("z", modifiers: .command)
                HStack {
                    Text("So, I made this with CreatML in the hope that I can solve these problems and they could focus more on their work.")
                        .font(.title)
                        .foregroundStyle(.white)
                    LazyVGrid(columns: Constants.columns5, spacing: 20) {
                        ForEach(Constants.symbols, id: \.self) { symbolName in
                            Image(systemName: symbolName)
                                .font(.system(size: 40))
                                .foregroundStyle(.white)
                        }
                    }
                }
                Spacer()
                    .frame(height: 50)
                HStack {
                    Text("⚠️ Icons including letters, numbers or figures may not be searchable.")
                        .foregroundStyle(.white)
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
                                        if let ciImage = CIImage(image: uiImage) {
                                            predict(image: ciImage)
                                        } else {
                                            self.showErrorAlert = true
                                        }
                                    } else {
                                        self.showErrorAlert = true
                                    }
                                }
                                .buttonStyle(BorderedProminentButtonStyle())
                                .padding([.bottom, .trailing])
                            }
                        }
                    }
                    NavigationView {
                        ZStack {
                            Color.neutral
                            VStack {
                                Text("You can search with the keyword below\nPress the button to see if there's a symbol you're looking for")
                                    .multilineTextAlignment(.center)
                                    .font(.headline)
                                    .foregroundStyle(Color.primary100)
                                    .padding()
                                Spacer()
                                NavigationLink(
                                    destination: SFSymbolsView(keyword: selectedLabel)
                                        .navigationTitle(selectedLabel),
                                    isActive: $isNavigate,
                                    label: { EmptyView() }
                                )
                                ForEach(results, id: \.self) { result in
                                    Button {
                                        selectedLabel = result.label
                                        isNavigate = true
                                    } label : {
                                        VStack(spacing: 2) {
                                            let label = result.label.replacingOccurrences(of: "_", with: ".")
                                            Text("\(label)")
                                                .font(.callout)
                                                .bold()
                                                .foregroundStyle(.white)
                                            Text("confidence **\(result.confidence)**%")
                                                .font(.callout)
                                                .foregroundStyle(.white.opacity(0.8))
                                        }
                                        .frame(width: 350)
                                    }
                                    .padding(2)
                                    .buttonStyle(BorderedButtonStyle())
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color.neutral)
                        }
                    }
                    .navigationViewStyle(StackNavigationViewStyle())
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
            
            if showErrorAlert {
                Color.black
                    .opacity(0.8)
                VStack(spacing: 10) {
                    Image(systemName: "exclamationmark.warninglight.fill")
                        .font(.title)
                        .foregroundStyle(.white)
                    Text("An error occured.\nPlease run the app again.")
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                }
                .padding(30)
                .background (
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.gray)
                )
            }
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
                    confidence: confidence == 0 ? 1 : confidence
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
    @State private var showClipboardAlert = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Color.neutral
            ScrollView {
                VStack {
                    Text("Click to copy the name to the clipboard")
                        .font(.headline)
                        .foregroundStyle(Color.primary100)
                    LazyVGrid(columns: Constants.column1) {
                        ForEach(systemNames, id: \.self) { systemName in
                            ZStack {
                                Rectangle()
                                    .stroke(Color.primary100, lineWidth: 0.5)
                                    .background(Color.neutral)
                                HStack(spacing: 10) {
                                    Image(systemName: systemName)
                                        .font(.largeTitle)
                                        .padding()
                                        .foregroundStyle(.white)
                                        .frame(width: 80)
                                    Text(systemName)
                                        .font(.subheadline)
                                        .foregroundStyle(.white)
                                    Spacer()
                                }
                            }
                            .onTapGesture {
                                UIPasteboard.general.string = systemName
                                showClipboardAlert = true
                            }
                        }
                    }
                }
                .padding()
                .padding(.top, 40)
            }
            VStack {
                ZStack {
                    HStack {
                        Spacer()
                        Text(keyword)
                            .foregroundStyle(Color.accentColor)
                            .font(.body)
                        Spacer()
                    }
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.accentColor)
                        }
                        .padding()
                        Spacer()
                    }
                }
                .background(Color.black.opacity(0.3))
                Spacer()
                Spacer()
            }
            
            if showClipboardAlert {
                Color
                    .black
                    .opacity(0.7)
                    .ignoresSafeArea()
                HStack(spacing: 10) {
                    Image(systemName: "doc.on.clipboard")
                        .font(.title3)
                        .foregroundStyle(.white)
                    Text("Copied to clipboard")
                        .font(.title3)
                        .foregroundStyle(.white)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.gray.opacity(0.5))
                )
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        showClipboardAlert = false
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}
