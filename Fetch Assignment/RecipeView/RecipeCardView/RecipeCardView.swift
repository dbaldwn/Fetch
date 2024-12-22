//
//  RecipeCardView.swift
//  Fetch Assignment
//
//  Created by Daniel Baldwin on 12/15/24.
//

import SwiftUI

struct RecipeCardView: View {
    @Environment(\.dynamicTypeSize)
    var dynamicTypeSize

    let recipe: Recipe

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            CachedAsyncImage(url: recipe.photoURLSmall) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                case .empty:
                    ProgressView()
                case .failure:
                    Color.gray
                    Image(systemName: "photo")
                        .frame(width: 50, height: 50)
                @unknown default:
                    fatalError()
                }
            }
            .cornerRadius(6)
            .frame(width: 120, height: 120)
            VStack(alignment: .leading) {
                Text(recipe.cuisine)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                Text(recipe.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                    .frame(height: dynamicTypeSize > .large ? 60 : 50, alignment: .topLeading)
                Spacer()
            }
            .padding(.top, 10)

            VStack(alignment: .trailing) {
                if let youtubeURL = recipe.youtubeURL {
                    Button {
                        if UIApplication.shared.canOpenURL(youtubeURL) {
                            UIApplication.shared.open(youtubeURL, options: [:])
                        }
                    } label: {
                        Image(systemName: "video.fill")
                    }
                    .frame(width: 44, height: 44)
                }

                if let sourceURL = recipe.sourceURL {
                    Button {
                        if UIApplication.shared.canOpenURL(sourceURL) {
                            UIApplication.shared.open(sourceURL, options: [:])
                        }
                    } label: {
                        Image(systemName: "link")
                    }
                    .frame(width: 44, height: 44)
                }
            }

        }
        .padding(10)
        .cornerRadius(10)
    }



}
