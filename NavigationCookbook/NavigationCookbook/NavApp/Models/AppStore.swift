/*
Centralized app store for UI state (Zustand-like pattern).
Access from any view using @EnvironmentObject without prop drilling.
*/

import Combine
import SwiftUI

final class AppStore: ObservableObject {
    @Published var showExperiencePicker = false
    
    static let shared = AppStore()
    
    private init() {}
}

