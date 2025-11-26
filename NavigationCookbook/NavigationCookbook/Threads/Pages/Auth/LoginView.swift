import SwiftUI

struct LoginView: View {
    @ObserveInjection var inject

    @State private var email = ""
    @State private var password = ""

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
                    TextField("Enter your email", text: $email)
                        .modifier(FormTextFieldModifier())
                        .autocorrectionDisabled()
                    SecureField("Enter your password", text: $password)
                        .modifier(FormTextFieldModifier())
                }

                NavigationLink(destination: ForgetPasswordView()) {
                    Text("Forgot password?")
                        .modifier(LinkTextModifier())
                }

                Button {
                    print("Login")
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
