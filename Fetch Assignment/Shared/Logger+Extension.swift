//
//  Logger+Extension.swift
//  Fetch Assignment
//
//  Created by Daniel Baldwin on 12/15/24.
//

import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let decode = Logger(subsystem: subsystem, category: "decode")
    static let networking = Logger(subsystem: subsystem, category: "networking")
}
