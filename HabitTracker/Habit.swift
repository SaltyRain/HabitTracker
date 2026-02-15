//
//  Habit.swift
//  HabitTracker
//
//  Created by SaltyRain on 14.02.26.
//


import Foundation
import SwiftData

@Model
final class Habit {
    var title: String
    var createdAt: Date
    var isCompletedToday: Bool
    
    init(title: String, createdAt: Date = .now, isCompletedToday: Bool = false) {
        self.title = title
        self.createdAt = createdAt
        self.isCompletedToday = isCompletedToday
    }
}
