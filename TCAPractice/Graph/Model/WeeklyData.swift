//
//  WeeklyData.swift
//  TCAPractice
//
//  Created by Raymond Chen on 1/5/24.
//

import Foundation

struct WeeklyData: Identifiable, Equatable, Codable {
    
    enum Day: String, CaseIterable, Codable {
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        case sunday
        
        var name: String {String(self.rawValue.capitalized.prefix(3))}
        
    }
    enum QuestionType: String, CaseIterable, Equatable, Hashable, Codable, Identifiable {
        var id: Self { self }
        
        case swift
        case swiftUI
        
        var name: String {self.rawValue}
    }
    var count: Double
    var isCorrect: Bool
    var day: Day
    var questionType: QuestionType
    var id = UUID()
}

extension WeeklyData {
    static let mockArray: [Self] = {
        var array: [Self] = []

        for (i,day) in Day.allCases.enumerated() {
            array.append(Self(count: Double([5,10,7,8,8,11,12][i]), isCorrect: true, day: day, questionType: .swift))
            array.append(Self(count: Double([5,0,3,2,2,4,3][i]), isCorrect: false, day: day, questionType: .swift))
            array.append(Self(count: Double([6,9,7,12,14,15,17][i]), isCorrect: true, day: day, questionType: .swiftUI))
            array.append(Self(count: Double([4,1,3,3,1,0,3][i]), isCorrect: false, day: day, questionType: .swiftUI))
        }
        return array
    }()
    
    static let mock = Self(
        count: 20,
        isCorrect: true,
        day: .monday,
        questionType: .swift
    )
}
