import SwiftUI

struct LoginView: View {
    @ObserveInjection var inject

    @StateObject private var loginViewModel = AuthModal()

    var body: some View {
        NavigationStack {
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
                        text: $loginViewModel.email,
                        autocorrectionDisabled: true,
                        autocapitalization: .none
                    )

                    FormTextField(
                        placeholder: "Enter your password",
                        text: $loginViewModel.password,
                        autocorrectionDisabled: true,
                        autocapitalization: .none,
                        secure: true
                    )
                }

                NavigationLink(destination: ForgetPasswordView()) {
                    Text("Forgot password?")
                        .modifier(LinkTextModifier())
                }

                FilledButton(
                    action: {
                        Task {
                            try await loginViewModel.loginWithEmail()
                        }
                    }, title: "Login", flexible: true)

                Spacer()

                Divider()

                NavigationLink(
                    destination: SignUpView()
                        .navigationBarBackButtonHidden(true)
                ) {
                    Text("Don't have an account? Sign up")
                        .modifier(LinkTextModifier(center: true))
                }
            }
            .padding()
        }
        //----------------------------------
        .enableInjection()
        //----------------------------------
    }
}
