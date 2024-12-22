//
//  Mockable.swift
//  Fetch Assignment
//
//  Created by Daniel Baldwin on 12/21/24.
//

import Foundation
import OSLog

public enum MockableError: Error {
    case error
}

protocol Mockable: Codable { }

extension Mockable {
    static func mock<T>(for resource: String? = nil) throws -> T where T: Mockable {
        let decoder = JSONDecoder()
        guard let url = Bundle.main.url(forResource: resource ?? String(describing: Self.self), withExtension: "json") else {
            throw MockableError.error
        }
        let data = try Data(contentsOf: url)
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            Logger.decode.error("Decoding Error: \(error.localizedDescription)")
            throw NetworkServiceError.decoding(message: "Error decoding \(resource ?? String(describing: Self.self)).")
        }
    }
}
