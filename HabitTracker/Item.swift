//
//  Item.swift
//  HabitTracker
//
//  Created by Regiothek on 14.02.26.
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
