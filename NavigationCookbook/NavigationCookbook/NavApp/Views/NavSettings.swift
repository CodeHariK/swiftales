import SwiftUI

struct NavSettingsView: View {
    var body: some View {
        TabView {
            Tab("General", systemImage: "gear") {
                GeneralSettingsView()
            }
            Tab("Advanced", systemImage: "star") {
                Menu("Actions") {
                    Button {
                        // Duplicate action.
                    } label: {
                        Text("Duplicate")
                        Text("Duplicate the component")
                    }
                    Button {
                        // Rename action.
                    } label: {
                        Text("Rename")
                        Text("Rename the component")
                    }
                    Button {
                        // Delete action.
                    } label: {
                        Text("Delete…")
                        Text("Delete the component")
                    }
                }
            }
        }
        .scenePadding()
        .frame(maxWidth: 350, minHeight: 100)
    }
}

struct GeneralSettingsView: View {
    @AppStorage("showPreview") private var showPreview = true
    @AppStorage("fontSize") private var fontSize = 12.0

    var body: some View {
        Form {
            Toggle("Show Previews", isOn: $showPreview)
            Slider(value: $fontSize, in: 9...96) {
                Text("Font Size (\(fontSize, specifier: "%.0f") pts)")
            }
        }
    }
}
