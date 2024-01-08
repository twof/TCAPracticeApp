import XCTest
@testable import TCAPracticeCore
import ComposableArchitecture

@MainActor
final class TCAPracticeCoreTests: XCTestCase {
  func testLoadAll() async throws {
    let mocked = loadJSON()
    let testStore = TestStore(initialState: QuizFeatureReducer.State()) {
      QuizFeatureReducer().dependency(\.apiClient, APIClient(getAllQuestions: { mocked }))
    }
    await testStore.send(.loadAllQuestions)
    await testStore.receive(.nextQuestion(nil))
  }

  func testSwipe() async throws {
    let mockedCurrentQuestion = Question(id: 1, codeSnippet: "test", answers: [])
    let testStore = TestStore(
        initialState: QuizFeatureReducer.State(
        currentQuestion: mockedCurrentQuestion, offset: -15)) {
      QuizFeatureReducer()
    }
    let mockedGeometry: CGFloat = 10

    await testStore.send(.swipe(mockedGeometry))

    await testStore.receive(.changeOffset(0)) { state in
      state.offset = 0
    }
    await testStore.receive(.nextQuestion(mockedCurrentQuestion))
  }
}
