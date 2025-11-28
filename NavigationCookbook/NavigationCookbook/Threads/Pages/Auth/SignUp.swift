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
                FormTextField(
                    placeholder: "Enter your email",
                    text: $signUpViewModel.email,
                    autocorrectionDisabled: true,
                    autocapitalization: .none
                )

                FormTextField(
                    placeholder: "Enter your password",
                    text: $signUpViewModel.password,
                    autocorrectionDisabled: true,
                    autocapitalization: .none,
                    secure: true
                )
            }

            FilledButton(
                action: {
                    Task {
                        try await signUpViewModel.createUser()
                    }
                }, title: "Sign up", flexible: true)

            Spacer()

            Divider()

            Button {
                dismiss()
            } label: {
                Text("Already have an account? Login")
                    .modifier(LinkTextModifier(center: true))
            }

        }
        .padding()

        //----------------------------------
        .enableInjection()
        //----------------------------------
    }
}
