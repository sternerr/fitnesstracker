//
//  Item.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-02-06.
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
