//
//  RecipeDataTests.swift
//  Fetch AssignmentTests
//
//  Created by Daniel Baldwin on 12/21/24.
//

import XCTest

@testable import Fetch_Assignment

class RecipeDataTests: XCTestCase {

    func testRecipeDecoding_succeeds() throws {
        let recipes: RecipeData = try RecipeData.mock()
        XCTAssertNotNil(recipes)
    }

    func testEmptyRecipesEmpty_empty() throws {
        let emptyRecipes: RecipeData = try RecipeData.mock(for: "EmptyRecipes")
        XCTAssert(emptyRecipes.recipes.isEmpty)
    }

    func testMalformedRecipes_throwsError() throws {
        XCTAssertThrowsError(
            try self.malformedRecipes()
        ) { error in
            XCTAssertEqual(
                error as! NetworkServiceError,
                NetworkServiceError.decoding(message: "Error decoding MalformedRecipes.")
            )
        }
    }

    private func malformedRecipes() throws -> RecipeData {
        try RecipeData.mock(for: "MalformedRecipes")
    }
}
