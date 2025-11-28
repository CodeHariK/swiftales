import SwiftUI

#if os(iOS)
    import UIKit
#endif

struct FilledButton: View {

    var action: () -> Void
    var title: String
    var flexible: Bool = false

    var body: some View {
        Button(action: action) {
            Text(title)
        }
        .buttonStyle(FilledButtonStyle(flexible: flexible))
    }
}

struct FilledButtonStyle: ButtonStyle {
    var flexible: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, AppTheme.buttonPaddingHorizontal)
            .padding(.vertical, AppTheme.buttonPaddingVertical)
            .frame(maxWidth: flexible ? .infinity : nil)
            .background(Color.themePrimary)
            .foregroundColor(Color.themeOnPrimary)
            .cornerRadius(AppTheme.cornerRadius)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

struct OutlinedButton: View {

    var action: () -> Void
    var title: String
    var flexible: Bool = false

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppTheme.buttonFont)
                .padding(.horizontal, AppTheme.buttonPaddingHorizontal)
                .padding(.vertical, AppTheme.buttonPaddingVertical)
                .frame(maxWidth: flexible ? .infinity : nil)
                .background(
                    RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                        .stroke(Color(.systemGray), lineWidth: 1)
                )
                .foregroundColor(.themePrimary)
        }
    }
}

struct LinkTextModifier: ViewModifier {
    var center: Bool = false

    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .padding(.vertical, 8)
            .foregroundColor(.linkText)
            .frame(maxWidth: .infinity, alignment: center ? .center : .trailing)
    }
}

struct FormTextField: View {
    var placeholder: String
    @Binding var text: String

    var autocorrectionDisabled: Bool = false
    var autocapitalization: UITextAutocapitalizationType = .none

    var secure: Bool = false

    var body: some View {
        Group {
            if secure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .font(AppTheme.formFont)
        .foregroundColor(.formFieldText)
        .padding(AppTheme.formFieldPadding)
        .background(Color.formFieldBackground)
        .cornerRadius(AppTheme.cornerRadius)
        .autocorrectionDisabled(autocorrectionDisabled)
        .autocapitalization(autocapitalization)
    }
}
