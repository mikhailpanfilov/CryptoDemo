//
//  StorageContext.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 4/13/18.
//  Copyright © 2018 Mikhail Panfilov. All rights reserved.
//

import Foundation


struct Sorted {
    var name: String
    var price: Double
    var ascending: Bool = true
}

protocol StorageContext {
    func save(object: Storable) throws
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> ()))
}


enum StorageError: Error {
    case saveObject
    
    var localizedDescription: String {
        switch self {
        case .saveObject:
            return "Unabel to save object to database"
        }
    }
}
