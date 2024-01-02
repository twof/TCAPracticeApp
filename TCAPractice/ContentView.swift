import SwiftUI
import TCAPracticeCore
import ComposableArchitecture

struct ContentView: View {

  let store: StoreOf<QuizFeatureReducer>

    var body: some View {
      WithViewStore(store, observe: {$0}) { viewStore in
        GeometryReader(content: { geometry in
          cardView(viewStore)
            .offset(x: viewStore.offset)
            .gesture(
              DragGesture()
                .onChanged({ gesture in
                  viewStore.send(.changeOffset(gesture.translation.width))
                })
                .onEnded({ _ in
                  if viewStore.offset < -geometry.size.width * 0.5 {
                    viewStore.send(.swipe(.left, -geometry.size.width))
                  } else if viewStore.offset > geometry.size.width * 0.5 {
                    viewStore.send(.swipe(.right, geometry.size.width))
                  }
                })
            )
            .task {
              //tell task to cancel if you navigate away from this view
              await viewStore.send(.loadAllQuestions).finish()
            }
        })
      }
    }

  func cardView(_ viewStore: ViewStore<QuizFeatureReducer.State, QuizFeatureReducer.Action>) -> some View {
    VStack(spacing: 16) {

      if let questionId = viewStore.currentQuestionViewModel?.questionId,
         let answers = answerViewsDict[questionId],
         let id = viewStore.currentQuestionViewModel?.answerDisplayed.id,
         let answer = answers[id] {
        AnyView(answer)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background {
            RoundedRectangle(cornerRadius: 12).fill(Color.blue)
          }
          .padding()
      }

      if let question = viewStore.currentQuestionViewModel?.question {
        Text(question)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background {
            RoundedRectangle(cornerRadius: 12).fill(Color.red)
          }
          .padding()
      }
    }
  }
}

#Preview {
  let store = Store(initialState: QuizFeatureReducer.State(), reducer: {QuizFeatureReducer()})
    return ContentView(store: store)
}
