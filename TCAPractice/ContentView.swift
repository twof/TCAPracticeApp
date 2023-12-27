import SwiftUI

struct ContentView: View {
  @State var show = false
  var body: some View {
    NavigationStack {
      QuestionView()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(white: 0.85).gradient)
  }
}

#Preview {
  ContentView()
}
