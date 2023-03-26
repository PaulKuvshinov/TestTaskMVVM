//
//  NetworkErrors.swift
//  TestTaskMVVM
//
//  Created by Paul on 22.03.2023.
//

import Foundation

enum NetworkError: Error {
    case lostNetworkConnection
    case incorrectData
    case serverError(error: Error)
}

extension NetworkError: LocalizedError {
        var errorDescription: String? {
        switch self {
        case .incorrectData:
            return "Incorrect data"
        case .lostNetworkConnection:
            return "Lost network connection"
        case.serverError(let error):
            return "Server error: \(error.localizedDescription)"
        }
    }
}
