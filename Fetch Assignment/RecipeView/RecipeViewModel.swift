//
//  RecipeViewModel.swift
//  Fetch Assignment
//
//  Created by Daniel Baldwin on 12/15/24.
//

import Foundation
import OSLog

@MainActor
class RecipeViewModel: ObservableObject {
    @Published private(set) var fetchState: FetchState<[Recipe]> = .loading
    @Published private(set) var recipes: [Recipe] = []

    func fetchData() async {
        if recipes.isEmpty {
            fetchState = .loading
        }
        do {
            let path = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json" // Regular Data
            // let path = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json" // Malformed Data
            // let path = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json" // Empty Data
            let request = Request(path: path)
            let fetchedData: FetchedDataWithEntity<RecipeData> = try await NetworkService.fetch(with: request)
            switch fetchedData {
            case .success(let data):
                self.recipes = data.recipes
                Logger.networking.log("Success")
                fetchState = .success
            case .success304:
                Logger.networking.log("Success with no change")
                fetchState = .successWithNoChange
            }
        } catch {
            Logger.networking.error("Error: \(error.localizedDescription)")
            fetchState = .error(errorMessage: "Something went wrong.  Try again")
        }
    }
}
