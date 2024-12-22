//
//  ContentView.swift
//  Fetch Assignment
//
//  Created by Daniel Baldwin on 12/15/24.
//

import SwiftUI

struct RecipeView: View {
    @StateObject var viewModel: RecipeViewModel

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Recipes")
                .navigationBarTitleDisplayMode(.large)
        }
        .task {
            await viewModel.fetchData()
        }
        .refreshable {
            await viewModel.fetchData()
        }
    }

    @ViewBuilder var content: some View {
        List {
            switch viewModel.fetchState {
            case .loading:
                ProgressView()
                    .listRowSeparator(.hidden)
            case .success, .successWithNoChange:
                if viewModel.recipes.isEmpty {
                    Text("No recipes found")
                        .listRowSeparator(.hidden)
                } else {
                    ForEach(viewModel.recipes) { recipe in
                        RecipeCardView(recipe: recipe)
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .background(.clear)
                                    .foregroundColor(.cellBackground)
                                    .padding(
                                        EdgeInsets(
                                            top: 10,
                                            leading: 15,
                                            bottom: 10,
                                            trailing: 15
                                        )
                                    )
                            )
                            .listRowSeparator(.hidden)
                    }
                }

            case .error(let errorMessage):
                VStack(alignment: .center) {
                    Text(errorMessage)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    Button {
                        Task {
                            await viewModel.fetchData()
                        }
                    } label: {
                        Text("Retry")
                            .font(.body)
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal, 30)
                .listRowSeparator(.hidden)
            case .none:
                EmptyView()
            }
        }
        .buttonStyle(.plain)
        .listStyle(.plain)
    }
}
