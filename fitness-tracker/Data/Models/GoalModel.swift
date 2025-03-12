//
//  GoalModel.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-03-09.
//

import SwiftData
import Foundation
    
@Model
class GoalModel: Identifiable {
    var title: String
    var goalDescription: String
    var measurement: String
    var amount: Int
    var exercise: String
    
    init(title: String, goalDescription: String, amount: Int, measurement: String, exercise: String) {
        self.title = title
        self.goalDescription = goalDescription
        self.measurement = measurement
        self.amount = amount
        self.exercise = exercise
    }
}
