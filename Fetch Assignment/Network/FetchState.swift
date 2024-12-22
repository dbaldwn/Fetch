//
//  FetchState.swift
//  Fetch Assignment
//
//  Created by Daniel Baldwin on 12/15/24.
//

import Foundation

enum FetchState<Data> {
    case loading
    case success
    case successWithNoChange
    case error(errorMessage: String)
    case none
}
