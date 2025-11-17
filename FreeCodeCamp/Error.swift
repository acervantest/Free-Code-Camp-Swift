//
//  Error.swift
//  FreeCodeCamp
//
//  Created by Alejandro Cervantes on 2025-11-16.
//

import Foundation

enum APIConfigError: Error, LocalizedError {
    case fileNotFound
    case dataloadingFailed(underlyingError: Error)
    case decodingFailed(underlyingError: Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "API Configuration file not found."
        case let .dataloadingFailed(underlyingError):
            return "Failed to load data from API configuration file: \(underlyingError.localizedDescription)."
        case let .decodingFailed(underlyingError):
            return "Failed to decode API configuration: \(underlyingError.localizedDescription)."
        }
    }
}

enum NetworkError: Error, LocalizedError {
    case badURLResponse(underlyingResponse: Error)
    case missingConfig
    case urlBuildFailed
    
    var errorDescription: String? {
        switch self {
        case let .badURLResponse(underlyingResponse):
            return "Failed to parse URL response: \(underlyingResponse.localizedDescription)."
        case .missingConfig:
            return "Missing API configuration."
        case .urlBuildFailed:
            return "Failed to build URL."
        }
    }
}
