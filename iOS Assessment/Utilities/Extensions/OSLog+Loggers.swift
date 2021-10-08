//
//  OSLog+Loggers.swift
//  iOS Assessment
//
//  Created by Ghalaab on 08/10/2021.
//

import Foundation
import os.log

extension OSLog {

    private static let subsystem = Bundle.main.bundleIdentifier!
    static let modelsLogger = OSLog(subsystem: OSLog.subsystem, category: "Models")
    static let requestsLogger = OSLog(subsystem: OSLog.subsystem, category: "Requests")
}
