//
//  noteModel.swift
//  EvoLabTest
//
//  Created by md760 on 4/20/19.
//  Copyright © 2019 md760. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
final class Note: Object {
    
     dynamic var noteDate: Date?
     dynamic var noteText: String?
}
