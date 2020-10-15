//
//  RealmStorageContext.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 4/13/18.
//  Copyright © 2018 Mikhail Panfilov. All rights reserved.
//

import Foundation
import RealmSwift


class RealmStorageContext: StorageContext {
    
    var realm: Realm?
    
    init() {
        configureRealm()
    }
    
    private func configureRealm() {
        let configuration = Realm.Configuration()
        try? self.realm = Realm(configuration: configuration)
        realm?.logFileURL()
    }
    
    func safeWrite(_ block: (() throws -> Void)) throws {
        guard let realm = self.realm else {
            throw NSError()
        }
        
        if realm.isInWriteTransaction {
            try block()
        } else {
            try realm.write(block)
        }
    }
    
}

extension RealmStorageContext {
    
    func save(object: Storable) throws {
        guard let realm = self.realm else { throw NSError() }
        
        try self.safeWrite {
            realm.add(object as! Object, update: true)
        }
    }
    
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> ())) where T : Storable {
        var objects = self.realm?.objects(model as! Object.Type)
        
        if let predicate = predicate {
            objects = objects?.filter(predicate)
        }
        
        if let sorted = sorted {
            objects = objects?.sorted(byKeyPath: sorted.name, ascending: sorted.ascending)
        }
        
        var accumulate: [T] = [T]()
        for object in objects! {
            accumulate.append(object as! T)
        }
        
        completion(accumulate)
    }
}

extension Realm {
    func logFileURL() {
        print("\n\nRealm storage path\n\(Realm.Configuration.defaultConfiguration.fileURL!.absoluteString.replacingOccurrences(of: "file://", with: ""))\n")
    }
}
