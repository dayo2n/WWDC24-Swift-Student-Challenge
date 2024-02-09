import SwiftUI


struct ButtonView: View {
    @Binding var selectedPageTag: Int
    var body: some View {
        HStack {
            if !Constants.pagesNotToShow.contains(selectedPageTag) {
                if selectedPageTag > Constants.minPageRange {
                    MovePrevButtonView(selectedPageNumber: $selectedPageTag)
                }
                Spacer()
                if selectedPageTag < Constants.maxPageRange {
                    MoveNextButtonView(selectedPageNumber: $selectedPageTag) 
                }
            }
        }
    }
}
struct MoveButtonView: View {
    let label: String
    var body: some View {
        Text(label)
            .foregroundStyle(.white)
            .font(.system(size: 30, weight: .semibold))
            .padding(.horizontal, 50)
            .padding(.vertical, 30)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(Color.primary500)
            )
    }
}

struct MoveNextButtonView: View {
    @Binding var selectedPageNumber: Int
    var body: some View {
        Button {
            if selectedPageNumber == Constants.maxPageRange {
                selectedPageNumber = Constants.minPageRange
                return
            }
            selectedPageNumber += 1
        } label: {
            MoveButtonView(label: "NEXT")
        }
    }
}

struct MovePrevButtonView: View {
    @Binding var selectedPageNumber: Int
    var body: some View {
        Button {
            if selectedPageNumber == Constants.minPageRange {
                selectedPageNumber = Constants.maxPageRange
                return
            }
            selectedPageNumber -= 1
        } label: {
            MoveButtonView(label: "PREV")
        }
    }
}
