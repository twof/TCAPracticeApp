import HighlightSwift
import SwiftUI

struct QuestionView: View {
    var body: some View {
      VStack {
        Text("Which view matches the code?")
          .font(.headline)
        TabView {
          Rectangle()
            .fill(Color.blue)
          Rectangle()
            .fill(Color.red)
          Rectangle()
            .fill(Color.purple)
        }
        .tabViewStyle(.page)
        .clipped()
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
        .padding()
        Button("Choose") {
          print("Choose")
        }
        .buttonStyle(BorderedProminentButtonStyle())
        HStack(alignment: .top) {
          VStack(alignment: .leading) {
            ScrollView {
              CodeText("""
                var body: some View {
                  Rectangle()
                    .fill(Color.blue)
                    .overlay(Color.red)
                }
                """
              )
              .codeTextLanguage(.swift)
              .codeTextColors(.theme(.xcode))
              .padding()
            }
            Spacer()
          }
          Spacer()
        }
        .background { Color(white: 0.9) }
        .ignoresSafeArea(edges: .bottom)
      }
    }
}

#Preview {
    QuestionView()
}
