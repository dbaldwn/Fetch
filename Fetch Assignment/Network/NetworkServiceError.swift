//
//  NetworkServiceError.swift
//  Fetch Assignment
//
//  Created by Daniel Baldwin on 12/15/24.
//

import Foundation

enum NetworkServiceError: Error {
    case http(statusCode: Int)
    case decoding(message: String)
    case badResponse(message: String)
    case invalidUrl(urlStr: String)
    case invalidUrlComponents(message: String)
    case unavailableInternetConnection(Error)
    case cancelled(Error)
    case unknown(Error)

    var code: Int {
        switch self {
        case .http(let statusCode):
            return statusCode
        case .decoding:
            return 1
        case .badResponse, .invalidUrl, .invalidUrlComponents:
            return 0
        case .unavailableInternetConnection(let error), .cancelled(let error), .unknown(let error):
            return (error as NSError).code
        }
    }

    var debugDescription: String {
        switch self {
        case .http(let statusCode):
            return "Http response statusCode is \(statusCode)"
        case .decoding(let message):
            return message
        case .badResponse(let message):
            return message
        case .invalidUrl(let urlStr):
            return "Invalid url \(urlStr)"
        case .invalidUrlComponents(let message):
            return message
        case .unavailableInternetConnection:
            return "The Internet connection appears to be offline"
        case .cancelled:
            return "The request was cancelled"
        case .unknown(let error):
            return error.localizedDescription
        }
    }

    var isConnectionError: Bool {
        switch self {
        case .unavailableInternetConnection: true
        default: false
        }
    }

    var displayMessage: String {
        String(localized: isConnectionError ? "sorryNoInternet.title" : "sorryThePageFailedToLoad.title")
    }

    var displayIcon: String {
        String(localized: isConnectionError ? "wifi.exclamationmark" : "exclamationmark.circle")
    }
}

extension NetworkServiceError: Equatable {
    static func == (lhs: NetworkServiceError, rhs: NetworkServiceError) -> Bool {
        switch(lhs, rhs) {
        case (.http(let lStatusCode), .http(let rStatusCode)):
            return lStatusCode == rStatusCode
        case (.decoding(let lMessage), .decoding(let rMessage)):
            return lMessage == rMessage
        case (.badResponse(let lMessage), .badResponse(let rMessage)):
            return lMessage == rMessage
        case (.invalidUrl(let lUrl), .invalidUrl(let rUrl)):
            return lUrl == rUrl
        case (.invalidUrlComponents(let lMessage), .invalidUrlComponents(let rMessage)):
            return lMessage == rMessage
        case (.unavailableInternetConnection(let lError), .unavailableInternetConnection(let rError)):
            return (lError as NSError).code == (rError as NSError).code
        case (.unknown(let lError), .unknown(let rError)):
            return (lError as NSError).code == (rError as NSError).code
        default:
            return false
        }
    }
}
