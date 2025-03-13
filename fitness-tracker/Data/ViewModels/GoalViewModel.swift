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
class GoalViewModel: Identifiable {
    var modelContext: ModelContext? = nil
    var goal: GoalModel
   
    init(goal: GoalModel, modelContext: ModelContext? = nil) {
        self.goal = goal
        self.modelContext = modelContext
    }
    
    func save(title: String?, description: String?, amount: Int?, exercise: String?) {
        self.goal.title = title ?? self.goal.title
        self.goal.goalDescription = description ?? self.goal.goalDescription
        self.goal.amount = amount ?? self.goal.amount
        self.goal.exercise = exercise ?? self.goal.exercise
    }
    
    func remove() {
        guard let modelContext = self.modelContext else { return }
        
        modelContext.delete(goal)
    }
    

    
//    func totalSum(for goal: GoalModel) -> Double {
//        let sets = Double(goal.setsAmount ?? "0") ?? 0
//        let reps = Double(goal.repsAmount ?? "0") ?? 0
//        let volume = Double(goal.volumeAmount ?? "0") ?? 0
//        return sets * reps * volume
//    }
}
