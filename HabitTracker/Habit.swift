//
//  Habit.swift
//  HabitTracker
//
//  Created by Regiothek on 14.02.26.
//


import Foundation
import SwiftData

@Model
final class Habit {
    var title: String
    var createdAt: Date
    
    init(title: String, createdAt: Date = .now) {
        self.title = title
        self.createdAt = createdAt
    }
}
