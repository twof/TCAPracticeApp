// Universal global import
// Causes all files in TCAPractice to import TCAPracticeCore
@_exported import TCAPracticeCore
import SwiftUI

@main
struct TCAPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
