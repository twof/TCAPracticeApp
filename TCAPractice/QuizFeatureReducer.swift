//
//  QuizFeatureReducer.swift
//  TCAPractice
//
//  Created by S J on 12/22/23.
//

import Foundation
import ComposableArchitecture

enum SwipeType {
  case left
  case right
}

@Reducer
struct QuizFeatureReducer {
  struct State: Equatable {
    var allQuestions: [Question] // mutate it and remove answered correct question from it
    var currentQuestionViewModel: QuestionViewModel
    var currentQuestion: Question
  }
  
  enum Action: Equatable {
    case loadAllQuestions
    case nextQuestion
    case swipe(_ type: SwipeType)
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .loadAllQuestions:
        state.allQuestions = loadJSON()
        return .send(.nextQuestion)

      case .nextQuestion:
        guard !state.allQuestions.isEmpty,
              let currentQuestion = state.allQuestions.randomElement(),
              let displayedAnswer = currentQuestion.answers.randomElement() else { return .none }
        state.currentQuestion = currentQuestion
        state.currentQuestionViewModel = QuestionViewModel(question: currentQuestion.codeSnippet, answerDisplayed: displayedAnswer)
        return .none

      case .swipe(let type):
        switch type {
        case .right:
          if state.currentQuestionViewModel.answerDisplayed.correct,
             let index = state.allQuestions.firstIndex(of: state.currentQuestion) {
            state.allQuestions.remove(at: index)
          }

          return .send(.nextQuestion)
        case .left:
          if !state.currentQuestionViewModel.answerDisplayed.correct,
             let index = state.allQuestions.firstIndex(of: state.currentQuestion) {
            state.allQuestions.remove(at: index)
          }

          return .send(.nextQuestion)
        }

      }
    }
  }

  private func loadJSON() -> [Question] {
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
}
