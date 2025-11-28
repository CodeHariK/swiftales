/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A navigation experience picker used to select the navigation architecture
 for the app.
*/

import SwiftUI

struct ExperiencePicker: View {
    @Binding var experience: Experience?
    @Environment(\.dismiss) private var dismiss
    @State private var selection: Experience?

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Choose your navigation experience")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(2, reservesSpace: true)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.8)
                    .padding()
                Spacer()
                LazyVGrid(columns: columns) {
                    ForEach(Experience.allCases) { experience in
                        ExperiencePickerItem(
                            selection: $selection,
                            experience: experience)
                    }
                }
                Spacer()
            }
            .scenePadding()
            #if os(iOS)
                .safeAreaInset(edge: .bottom) {
                    ContinueButton(action: continueAction)
                    .disabled(selection == nil)
                    .scenePadding()
                }
            #endif
        }
        #if os(macOS)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    ContinueButton(action: continueAction)
                    .disabled(selection == nil)
                }
            }
            .frame(width: 600, height: 350)
        #endif
        .interactiveDismissDisabled(selection == nil)
    }

    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 250))]
    }

    func continueAction() {
        experience = selection
        dismiss()
    }
}

struct ExperiencePickerItem: View {
    @Binding var selection: Experience?
    var experience: Experience

    var body: some View {
        Button {
            selection = experience
        } label: {
            ExperienceCard(selection: $selection, experience: experience)
        }
        .buttonStyle(.plain)
    }
}

private struct ExperienceCard: View {
    @Binding var selection: Experience?
    var experience: Experience
    @State private var isHovering = false

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: experience.imageName)
                .font(.title)
                .foregroundStyle(shapeStyle(Color.accentColor))
            VStack(alignment: .leading) {
                Text(experience.localizedName)
                    .bold()
                    .foregroundStyle(shapeStyle(Color.primary))
                Text(experience.localizedDescription)
                    .font(.callout)
                    .lineLimit(3, reservesSpace: true)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(shapeStyle(Color.secondary))
            }
        }
        .shadow(radius: selection == experience ? 4 : 0)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(
                    selection == experience
                        ? AnyShapeStyle(Color.accentColor)
                        : AnyShapeStyle(BackgroundStyle()))
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(isHovering ? Color.accentColor : .clear)
        }
        .scaleEffect(isHovering ? 1.02 : 1)
        .onHover { isHovering in
            withAnimation {
                self.isHovering = isHovering
            }
        }
    }

    func shapeStyle<S: ShapeStyle>(_ style: S) -> some ShapeStyle {
        if selection == experience {
            return AnyShapeStyle(.background)
        } else {
            return AnyShapeStyle(style)
        }
    }
}

struct ExperienceButton: View {
    @EnvironmentObject private var appStore: AppStore

    var body: some View {
        Button {
            appStore.showExperiencePicker = true
        } label: {
            Label("Experience", systemImage: "wand.and.stars")
                .help("Choose your navigation experience")
        }
    }
}
