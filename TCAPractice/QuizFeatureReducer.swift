//
//  QuizFeatureReducer.swift
//  TCAPractice
//
//  Created by S J on 12/22/23.
//

import Foundation
import ComposableArchitecture

@Reducer
struct QuizFeatureReducer {
  struct State: Equatable {
    var allQuestions: [Question]
    var allQuestionsViewModel: [QuestionViewModel]
  }

  enum Action: Equatable {
    case loadAllQuestions
    case loadCurrentQuestion
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .loadAllQuestions:
        state.allQuestions = loadJSON()
        return .none
      case .loadCurrentQuestion:
        return .none
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
