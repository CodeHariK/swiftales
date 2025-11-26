import SwiftUI

struct FormTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(.formFieldText)
            .padding(12)
            .background(Color.formFieldBackground)
            .cornerRadius(8)
            .padding(.horizontal, 24)
    }
}

struct ExpandedFilledButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.buttonForeground)
            .frame(width: 352, height: 44)
            .background(Color.buttonBackground)
            .cornerRadius(8)
    }
}

struct LinkTextModifier: ViewModifier {
    var center: Bool = false

    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .padding(.vertical, 8)
            .padding(.trailing, center ? 0 : 24)
            .foregroundColor(.linkText)
            .frame(maxWidth: .infinity, alignment: center ? .center : .trailing)
    }
}
