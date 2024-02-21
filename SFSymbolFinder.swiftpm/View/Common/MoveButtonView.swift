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
    let isPrevButton: Bool
    var body: some View {
        HStack {
            if isPrevButton {
                Image(systemName: "chevron.backward")
                    .font(.title)
                    .foregroundStyle(Color.primary300)
                    .bold()
            }
            Text(label)
                .foregroundStyle(Color.primary300)
                .font(.title)
                .bold()
            if !isPrevButton {
                Image(systemName: "chevron.forward")
                    .font(.title)
                    .foregroundStyle(Color.primary300)
                    .bold()
            }
        }
        .padding(.vertical)
    }
}

struct MoveNextButtonView: View {
    @Binding var selectedPageNumber: Int
    var body: some View {
        Button {
            withAnimation(.easeIn) {
                if selectedPageNumber == Constants.maxPageRange {
                    selectedPageNumber = Constants.minPageRange
                    return
                }
                selectedPageNumber += 1
            }
        } label: {
            MoveButtonView(label: "NEXT", isPrevButton: false)
        }
    }
}

struct MovePrevButtonView: View {
    @Binding var selectedPageNumber: Int
    var body: some View {
        Button {
            withAnimation(.easeOut) {
                if selectedPageNumber == Constants.minPageRange {
                    selectedPageNumber = Constants.maxPageRange
                    return
                }
                selectedPageNumber -= 1
            }
        } label: {
            MoveButtonView(label: "PREV", isPrevButton: true)
        }
    }
}
