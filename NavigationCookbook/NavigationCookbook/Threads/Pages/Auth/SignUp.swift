import SwiftUI

struct SignUpView: View {
    @ObserveInjection var inject

    @State private var email = ""
    @State private var password = ""

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
                TextField("Enter your email", text: $email)
                    .modifier(FormTextFieldModifier())
                    .autocorrectionDisabled()
                SecureField("Enter your password", text: $password)
                    .modifier(FormTextFieldModifier())
            }

            Button {
                print("Sign up")
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
