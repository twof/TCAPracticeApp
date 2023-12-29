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
    var allQuestions: [Question]  = []// mutate it and remove answered correct question from it
    var currentQuestionViewModel: QuestionViewModel
    var currentQuestion: Question? = nil

  }
  
  enum Action: Equatable {
    case loadAllQuestions
    case nextQuestion(_ previousQuestion: Question? = nil)
    case swipe(_ type: SwipeType)
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .loadAllQuestions:
        state.allQuestions = loadJSON()
        return .send(.nextQuestion())

      case .nextQuestion:
        //next question should be different from the previous one if it's answered wrong
        guard !state.allQuestions.isEmpty,
              let currentQuestion = state.allQuestions.randomElement(),
              let displayedAnswer = currentQuestion.answers.randomElement() else { return .none }
        state.currentQuestion = currentQuestion
        state.currentQuestionViewModel = QuestionViewModel(question: currentQuestion.codeSnippet, answerDisplayed: displayedAnswer)
        return .none

      case .swipe(let type):
        switch type {
        case .right:
          if let currentQuestion = state.currentQuestion,
            state.currentQuestionViewModel.answerDisplayed?.correct == true,
             let index = state.allQuestions.firstIndex(of: currentQuestion) {
            state.allQuestions.remove(at: index)
            print("correct: this is the answer we are looking for")
          }

          return .send(.nextQuestion(state.currentQuestion))
        case .left:
          if let currentQuestion = state.currentQuestion,
            state.currentQuestionViewModel.answerDisplayed?.correct != true,
             let index = state.allQuestions.firstIndex(of: currentQuestion) {
            state.allQuestions.remove(at: index)
          }
          print("correct: this is not the answer we are looking for")

          return .send(.nextQuestion(state.currentQuestion))
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
