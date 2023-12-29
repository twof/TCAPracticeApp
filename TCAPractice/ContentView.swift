import SwiftUI
import ComposableArchitecture

struct ContentView: View {

  let store = Store(initialState: QuizFeatureReducer.State(currentQuestionViewModel: QuestionViewModel()), reducer: {QuizFeatureReducer()})

    var body: some View {
      WithViewStore(store, observe: {$0}) { viewStore in
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
        .task {
          viewStore.send(.loadAllQuestions)
        }
        .padding()
      }

    }
}

#Preview {
    ContentView()
}
