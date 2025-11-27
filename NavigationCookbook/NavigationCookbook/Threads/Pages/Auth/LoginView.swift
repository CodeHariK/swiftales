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
                    TextField("Enter your email", text: $loginViewModel.email)
                        .modifier(FormTextFieldModifier())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    SecureField("Enter your password", text: $loginViewModel.password)
                        .modifier(FormTextFieldModifier())
                        .autocapitalization(.none)
                }

                NavigationLink(destination: ForgetPasswordView()) {
                    Text("Forgot password?")
                        .modifier(LinkTextModifier())
                }

                Button {
                    Task {
                        try await loginViewModel.loginWithEmail()
                    }
                } label: {
                    Text("Login")
                        .modifier(ExpandedFilledButtonStyle())
                }

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
        }
        //----------------------------------
        .enableInjection()
        //----------------------------------
    }
}
