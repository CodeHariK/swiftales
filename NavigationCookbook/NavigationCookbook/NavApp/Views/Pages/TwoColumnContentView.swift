/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The content view for the two-column navigation split view experience.
*/

import SwiftUI

struct TwoColumnContentView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    var categories = Category.allCases
    var dataModel = DataModel.shared

    var body: some View {
        NavigationSplitView(
            columnVisibility: $navigationModel.columnVisibility
        ) {
            List(
                categories,
                selection: $navigationModel.selectedCategory
            ) { category in
                NavigationLink(category.localizedName, value: category)
            }
            .navigationTitle("Categories")
            .toolbar {
                ExperienceButton()
            }
        } detail: {
            NavigationStack(path: $navigationModel.recipePath) {
                RecipeGrid(category: navigationModel.selectedCategory)
            }
        }
    }
}

struct TwoColumnContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TwoColumnContentView()
                .environmentObject(NavigationModel(columnVisibility: .doubleColumn))
                .environmentObject(AppStore.shared)
            TwoColumnContentView()
                .environmentObject(
                    NavigationModel(
                        columnVisibility: .doubleColumn,
                        selectedCategory: .dessert)
                )
                .environmentObject(AppStore.shared)
            TwoColumnContentView()
                .environmentObject(
                    NavigationModel(
                        columnVisibility: .doubleColumn,
                        selectedCategory: .dessert,
                        recipePath: [.mock])
                )
                .environmentObject(AppStore.shared)
        }
    }
}
