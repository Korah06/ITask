//
//  Item.swift
//  ITask
//
//  Created by Mario Espasa Planells on 16/12/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
