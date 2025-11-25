/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The content view for the WWDC22 challenge.
*/

import SwiftUI

struct ChallengeContentView: View {
    @ObserveInjection var inject
    @EnvironmentObject private var navigationModel: NavigationModel
    var dataModel = DataModel.shared

    var body: some View {
        VStack {
            Text("Put your navigation skills to the test here")
            ExperienceButton()
        }
        .enableInjection()
    }
}

struct ChallengeContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeContentView()
            .environmentObject(AppStore.shared)
    }
}
