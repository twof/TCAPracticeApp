//
//  ChartView.swift
//  TCAPractice
//
//  Created by Raymond Chen on 1/5/24.
//

import ComposableArchitecture
import SwiftUI
import Charts

struct ChartViewFeature: Reducer {
    struct State:Equatable {
        var weeklyData: IdentifiedArrayOf<WeeklyData> = []
        @BindingState var questionType: WeeklyData.QuestionType = .swift
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
            }
        }
    }
}

extension Animation {
    static func ripple(index: Int) -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(2)
            .delay(0.03 * Double(index))
    }
}

struct ChartView: View {
    let store: StoreOf<ChartViewFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            VStack {
                Picker("Question Type", selection: viewStore.$questionType) {
                    ForEach(WeeklyData.QuestionType.allCases) { questionType in
                        Text(questionType.name)
                    }
                }
                .pickerStyle(.segmented)
                Chart {
                    ForEach(viewStore.weeklyData.filter({ data in
                        data.questionType == viewStore.questionType
                    })) { data in
                        BarMark(x: .value("Day", data.day.name),
                                y: .value("Total Count", data.count)
                        )
                        .foregroundStyle(by: .value("Correct", data.isCorrect ? "Green": "Red"))
                    }
                }
                .animation(.ripple(index: 0), value: viewStore.questionType)
            }
        }
        .chartForegroundStyleScale([
            "Red": .red, "Green": .green,
        ])
    }
}

#Preview {
    var mockArray: IdentifiedArrayOf<WeeklyData> = []
    for mock in WeeklyData.mockArray {
        mockArray.append(mock)
    }
    
    return ChartView(store: Store(
        initialState: ChartViewFeature.State(weeklyData: mockArray ),
        reducer: {
            ChartViewFeature()
        }))
}
