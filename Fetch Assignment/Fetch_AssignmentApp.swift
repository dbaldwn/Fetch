//
//  Fetch_AssignmentApp.swift
//  Fetch Assignment
//
//  Created by Daniel Baldwin on 12/15/24.
//

import SwiftUI

@main
struct Fetch_AssignmentApp: App {
    var body: some Scene {
        WindowGroup {
            RecipeView(viewModel: RecipeViewModel())
        }
    }
}
