import Foundation
import SwiftData
import SwiftUI

@main
struct PeopleWorkApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            MacHello()
            #else
            Text("Hello, Kid Promises!")
            #endif
        }
    }
}
