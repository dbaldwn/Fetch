//
//  Recipe.swift
//  Fetch Assignment
//
//  Created by Daniel Baldwin on 12/15/24.
//

import Foundation

// MARK: - RecipeData
struct RecipeData: Codable, Mockable {
    let recipes: [Recipe]
}

// MARK: - Recipe
struct Recipe: Codable, Identifiable, Mockable {
    let id: String
    let cuisine: String
    let name: String
    let photoURLLarge: URL?
    let photoURLSmall: URL?
    let sourceURL: URL?
    let youtubeURL: URL?

    enum CodingKeys: String, CodingKey {
        case cuisine, name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case id = "uuid"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}
