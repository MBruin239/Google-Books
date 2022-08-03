//
//  DataHelper.swift
//  Google Books
//
//  Created by Michael  Bruin on 8/3/22.
//

import Foundation

struct CastingError: Error {
    let fromType: Any.Type
    let toType: Any.Type
    init<FromType, ToType>(fromType: FromType.Type, toType: ToType.Type) {
        self.fromType = fromType
        self.toType = toType
    }
}

extension CastingError: LocalizedError {
    var localizedDescription: String { return "Can not cast from \(fromType) to \(toType)" }
}

extension CastingError: CustomStringConvertible { var description: String { return localizedDescription } }

// MARK: - Data cast extensions

extension Data {
    func toDictionary(options: JSONSerialization.ReadingOptions = []) throws -> [String: Any] {
        return try to(type: [String: Any].self, options: options)
    }

    func to<T>(type: T.Type, options: JSONSerialization.ReadingOptions = []) throws -> T {
        guard let result = try JSONSerialization.jsonObject(with: self, options: options) as? T else {
            throw CastingError(fromType: type, toType: T.self)
        }
        return result
    }
}
