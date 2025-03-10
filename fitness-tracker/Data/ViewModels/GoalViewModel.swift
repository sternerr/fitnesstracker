//
//  GoalViewModel.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-03-09.
//

import SwiftData
import SwiftUI
import Observation

@Observable
class GoalViewModel {
    var modelContext: ModelContext? = nil
    
    var goals: [GoalModel] = []
    
    func fetchGoals() {
        self.goals = try! self.modelContext?.fetch(FetchDescriptor<GoalModel>()) ?? []
    }
    
    func addGoal(title: String, description: String, setsAmount: String? = nil, repsAmount: String? = nil, volumeAmount: String? = nil) {
        let goal = GoalModel(title: title, goalDescription: description, setsAmount: setsAmount, repsAmount: repsAmount, volumeAmount: volumeAmount)
        self.modelContext?.insert(goal)
        try? self.modelContext?.save()
        fetchGoals()
    }
    
    func editGoal(goal: GoalModel?, title: String, description: String, setsAmount: String? = nil, repsAmount: String? = nil, volumeAmount: String? = nil) {
        goal?.title = title
        goal?.goalDescription = description
        goal?.setsAmount = setsAmount
        goal?.repsAmount = repsAmount
        goal?.volumeAmount = volumeAmount
        try? self.modelContext?.save()
    }
    
    func removeGoal(goal: GoalModel) {
        self.modelContext?.delete(goal)
        try? self.modelContext?.save()
        fetchGoals()
    }
}
