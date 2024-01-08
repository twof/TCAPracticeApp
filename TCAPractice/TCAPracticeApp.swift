// Universal global import
// Causes all files in TCAPractice to import TCAPracticeCore
@_exported import TCAPracticeCore
import SwiftUI
import ComposableArchitecture

@main
struct TCAPracticeApp: App {

    let store = Store(initialState: QuizFeatureReducer.State(), reducer: {QuizFeatureReducer()})
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
