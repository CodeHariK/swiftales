import SwiftUI

struct SignUpView: View {
    @ObserveInjection var inject

    @StateObject private var signUpViewModel = AuthModal()

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Spacer()

            Image(systemName: "cloud.bolt")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()

            VStack {
                TextField("Enter your email", text: $signUpViewModel.email)
                    .modifier(FormTextFieldModifier())
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                SecureField("Enter your password", text: $signUpViewModel.password)
                    .modifier(FormTextFieldModifier())
                    .autocapitalization(.none)
            }

            Button {
                Task {
                    try await signUpViewModel.createUser()
                }
            } label: {
                Text("Sign up")
                    .modifier(ExpandedFilledButtonStyle())
            }

            Spacer()

            Divider()

            Button {
                dismiss()
            } label: {
                Text("Already have an account? Login")
                    .modifier(LinkTextModifier(center: true))
            }

        }
        //----------------------------------
        .enableInjection()
        //----------------------------------
    }
}
