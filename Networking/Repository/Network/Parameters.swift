//
//  Parameters.swift
//  Networking
//
//  Created by Егор Бадмаев on 14.07.2022.
//

import Foundation

public extension Request {
    struct Parameters {
        
        public struct Configuration {
            public enum Destination {
                case query(arrayEncoding: ArrayEncoding, boolEncoding: BoolEncoding)
                case httpBody
            }
            
            public enum ArrayEncoding {
                case brackets
                case noBrackets
            }
            
            public enum BoolEncoding {
                case numeric
                case literal
            }
            
            public var destination: Destination
            public var updateHeaders: Bool
            
            public static let `defaultQuery` = Configuration(
                destination: .query(arrayEncoding: .brackets, boolEncoding: .literal),
                updateHeaders: true
            )
            
            public static let `defaultJson` = Configuration(
                destination: .httpBody,
                updateHeaders: true
            )
        }
        
        public let object: Any
        public let configuration: Configuration
        
        public init(object: [String: Any], configuration: Configuration = .defaultQuery) {
            self.object = object
            self.configuration = configuration
        }
        
        public init<T: Encodable>(object: T, configuration: Configuration = .defaultJson) throws {
            self.object = try JSONEncoder().encode(object)
            self.configuration = configuration
        }
        
        public init(object: Data, configuration: Configuration) throws {
            self.object = object
            self.configuration = configuration
        }
    }
}

// MARK: - ExpressibleByDictionaryLiteral
extension Request.Parameters: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, Any)...) {
        let dictionary = Dictionary(uniqueKeysWithValues: elements)
        let object = (dictionary as [String: Any?]).compactMapValues { $0 }
        self.init(object: object, configuration: .defaultQuery)
    }
}
