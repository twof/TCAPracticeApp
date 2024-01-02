//
//  Question.swift
//  TCAPractice
//
//  Created by S J on 12/22/23.
//

import Foundation

public struct Question: Codable, Identifiable, Equatable {
  public let id: Int
  public let codeSnippet: String
  public let answers: [Answer]
}

public struct Answer: Codable, Identifiable, Equatable {
  public let id: Int
  public var type: AnswerType = .swiftUI
  public let correct: Bool
}

public enum AnswerType: String, Codable {
  case swiftUI
  case debug
}

