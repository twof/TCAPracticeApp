//
//  Question.swift
//  TCAPractice
//
//  Created by S J on 12/22/23.
//

import Foundation

struct Question: Codable, Identifiable, Equatable {
  let id: Int
  let codeSnippet: String
  let answers: [Answer]
}

struct Answer: Codable, Identifiable, Equatable {
  let id: Int
  let type: AnswerType = .swiftUI
  let content: String
  let correct: Bool
}

enum AnswerType: Codable {
  case swiftUI
  case debug
}

