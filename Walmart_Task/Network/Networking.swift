//
//  Networking.swift
//  Walmart_Task
//
//  Created by Ismayil Ismayilov on 4/17/24.
//

import UIKit
import Combine

enum Result<Value: Decodable> {
    case success(Value)
    case failure(Bool)
}

typealias Handler = (Result<Data>) -> Void

enum NetworkError: Error {
    case invalidURL
    case decodingError
    
    var description: String {
        switch self {
        case .invalidURL:
            return "No URL found"
        case .decodingError:
            return "No data found"
        }
    }
}

public enum Method {
    case get
    case post
    case delete
    case other(method: String)
}

enum NetworkingError: String, LocalizedError {
    case jsonError = "JSON error"
    case other
    var localizedDescription: String { return NSLocalizedString(self.rawValue, comment: "")}
}

extension Method {
    public init(_ rawValue: String) {
        let method = rawValue.uppercased()
        switch method {
        case "GET":
            self = .get
        case "POST":
            self = .post
        case "DELETE":
            self = .delete
        default:
            self = .other(method: method)
        }
    }
}

extension Method: CustomStringConvertible {
    public var description: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        case .other(let method):
            return method.uppercased()
        }
    }
}

