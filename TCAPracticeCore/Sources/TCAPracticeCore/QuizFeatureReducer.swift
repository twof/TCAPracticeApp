//
//  QuizFeatureReducer.swift
//  TCAPractice
//
//  Created by S J on 12/22/23.
//

//keep business logic away from views, that's why I put it in TCAPracticeCore(platform independent)
import Foundation
import ComposableArchitecture

public enum SwipeType {
  case left
  case right
}

@Reducer
public struct QuizFeatureReducer {

  public init(){}

  public struct State: Equatable {

    public init(allQuestions: [Question] = [], currentQuestionViewModel: QuestionViewModel? = nil, currentQuestion: Question? = nil, offset: CGFloat = 0) {
      self.allQuestions = allQuestions
      self.currentQuestionViewModel = currentQuestionViewModel
      self.currentQuestion = currentQuestion
      self.offset = offset
    }
    
    public var allQuestions: [Question]  = []// mutate it and remove answered correct question from it
    public var currentQuestionViewModel: QuestionViewModel?
    public var currentQuestion: Question?
    public var offset: CGFloat = 0
  }
  
  public enum Action: Equatable {
    case loadAllQuestions
    case nextQuestion(_ previousQuestion: Question? = nil)
    case swipe(_ geometrySize: CGFloat)
    case changeOffset(_ offset: CGFloat)
  }

  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .loadAllQuestions:
        state.allQuestions = loadJSON()
        return .send(.nextQuestion())

      case .nextQuestion:
        guard !state.allQuestions.isEmpty,
              let currentQuestion = state.allQuestions.randomElement(),
              let displayedAnswer = currentQuestion.answers.randomElement() else { return .none }
        state.currentQuestion = currentQuestion
        state.currentQuestionViewModel = QuestionViewModel(question: currentQuestion.codeSnippet, answerDisplayed: displayedAnswer, questionId: currentQuestion.id)
        return .none

      case .changeOffset(let offset):
        state.offset = offset
        return .none

      case .swipe(let geometry):
        if state.offset < -geometry * 0.5 {
          state.offset = geometry
          if let currentQuestion = state.currentQuestion,
            state.currentQuestionViewModel?.answerDisplayed.correct != true,
             let index = state.allQuestions.firstIndex(of: currentQuestion) {
            state.allQuestions.remove(at: index)
            print("correct: this is not the answer we are looking for")
          }
          print("wrong: this is the answer we are looking for")

          //the same as the capture state above
          let state = state
          return .run { send in
            try await Task.sleep(for: .seconds(0.5))
            await send(.changeOffset(0))
            await send(.nextQuestion(state.currentQuestion))
          }
        } else if state.offset > geometry * 0.5 {
          state.offset = geometry
          if let currentQuestion = state.currentQuestion,
             state.currentQuestionViewModel?.answerDisplayed.correct == true,
             let index = state.allQuestions.firstIndex(of: currentQuestion) {
            state.allQuestions.remove(at: index)
            print("correct: this is the answer we are looking for")
          }
          print("wrong: this is the answer we are looking for")
          //to capture state( make a immutable copy of the state when the closure is created)
          return .run { [state] send in
            try await Task.sleep(for: .seconds(0.5))
            await send(.changeOffset(0))
            await send(.nextQuestion(state.currentQuestion))
          }
        }
        return .none
      }
    }
  }
}

public func loadJSON() -> [Question] {
  guard let url = Bundle.main.url(forResource: "MockedQuestions", withExtension: "json") else {
    return []
  }
  do {
    let data = try Data(contentsOf: url)
    let questions = try JSONDecoder().decode([Question].self, from: data)
    return questions
  } catch {
    print(error)
    return []
  }
}
