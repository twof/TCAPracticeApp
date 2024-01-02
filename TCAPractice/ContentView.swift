import SwiftUI
import ComposableArchitecture

struct ContentView: View {

  let store = Store(initialState: QuizFeatureReducer.State(currentQuestionViewModel: QuestionViewModel()), reducer: {QuizFeatureReducer()})
  @State private var offset: CGFloat = 0

    var body: some View {
      WithViewStore(store, observe: {$0}) { viewStore in
        GeometryReader(content: { geometry in
          cardView(viewStore)
            .offset(x: offset)
            .gesture(
              DragGesture()
                .onChanged({ gesture in
                  offset = gesture.translation.width
                })
                .onEnded({ _ in
                  if offset < -geometry.size.width * 0.5 {
                    offset = -geometry.size.width
                    viewStore.send(.nextQuestion(viewStore.currentQuestion))
                    Task {
                      try? await Task.sleep(nanoseconds: 200000000)
                      offset = 0
                    }
                  }
                })
            )
            .task {
              viewStore.send(.loadAllQuestions)
            }
        })
      }
    }

  func cardView(_ viewStore: ViewStore<QuizFeatureReducer.State, QuizFeatureReducer.Action>) -> some View {
      VStack(spacing: 16) {
        Text(viewStore.currentQuestionViewModel.answerDisplayed?.content ?? "")
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background {
            RoundedRectangle(cornerRadius: 12).fill(Color.blue)
          }

        Text(viewStore.currentQuestionViewModel.question)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background {
            RoundedRectangle(cornerRadius: 12).fill(Color.red)
          }
      }
      .padding()
  }
}

#Preview {
    ContentView()
}
