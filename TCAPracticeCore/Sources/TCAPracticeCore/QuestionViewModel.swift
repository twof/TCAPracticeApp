//
//  QuestionViewModel.swift
//  TCAPractice
//
//  Created by S J on 12/22/23.
//

import Foundation

public struct QuestionViewModel: Equatable {
  public init(question: String, answerDisplayed: Answer, questionId: Int) {
    self.question = question
    self.answerDisplayed = answerDisplayed
    self.questionId = questionId
  }
  
  public var question: String
  public var answerDisplayed: Answer
  public var questionId: Int
}
