//
//  File.swift
//
//
//  Created by S J on 1/7/24.
//

import Foundation
import ComposableArchitecture

extension DependencyValues {
  var apiClient: APIClient {
    get {self[ClientKey.self]}
    set{self[ClientKey.self] = newValue}
  }
}

struct APIClient {
  let getAllQuestions: () -> [Question]
  init(getAllQuestions: @escaping () -> [Question] = unimplemented()) {
    self.getAllQuestions = getAllQuestions
  }
}

enum ClientKey: DependencyKey {
  static let liveValue = APIClient(getAllQuestions: loadJSON)
  static let testValue = APIClient(getAllQuestions: unimplemented())
}
