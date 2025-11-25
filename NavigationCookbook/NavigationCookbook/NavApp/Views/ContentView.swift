/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The main content view the app uses to present the navigation experience
 picker and change the app navigation architecture based on the user selection.
*/

import Combine
import Inject
import SwiftUI

struct ContentView: View {
    @ObserveInjection var inject
    @SceneStorage("experience") private var experience: Experience?
    @SceneStorage("navigation") private var navigationData: Data?
    @StateObject private var navigationModel = NavigationModel()
    @StateObject private var appStore = AppStore.shared

    var body: some View {
        Group {
            switch experience {
            case .stack?:
                StackContentView()
            case .twoColumn?:
                TwoColumnContentView()
            case .threeColumn?:
                ThreeColumnContentView()
            case .challenge?:
                ChallengeContentView()
            case nil:
                VStack {
                    Text("🧑🏼‍🍳 Bon appétit!")
                        .font(.largeTitle)
                    ExperienceButton()
                }
                .padding()
                .onAppear {
                    appStore.showExperiencePicker = true
                }
            }
        }
        .environmentObject(navigationModel)
        .environmentObject(appStore)
        .sheet(isPresented: $appStore.showExperiencePicker) {
            ExperiencePicker(experience: $experience)
        }
        .task {
            if let jsonData = navigationData {
                navigationModel.jsonData = jsonData
            }
            for await _ in navigationModel.objectWillChangeSequence {
                navigationData = navigationModel.jsonData
            }
        }
        .enableInjection()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
