//
//  Storable.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 4/13/18.
//  Copyright © 2018 Mikhail Panfilov. All rights reserved.
//

import Foundation
import RealmSwift


///Dummy protocol for Entities
public protocol Storable { }

extension Object: Storable { }
