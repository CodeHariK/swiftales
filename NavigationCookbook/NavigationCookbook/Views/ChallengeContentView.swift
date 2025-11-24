/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The content view for the WWDC22 challenge.
*/

import SwiftUI

struct ChallengeContentView: View {
    @ObserveInjection var inject
    @Binding var showExperiencePicker: Bool
    @EnvironmentObject private var navigationModel: NavigationModel
    var dataModel = DataModel.shared

    var body: some View {
        VStack {
            Text("Put your navigation skills to the test here")
            ExperienceButton(isActive: $showExperiencePicker)
        }
        .enableInjection()
    }
}

struct ChallengeContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeContentView(showExperiencePicker: .constant(false))
    }
}
