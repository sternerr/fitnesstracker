//
//  HistoryPage-ViewModel.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-12.
//

import SwiftData
import Foundation

@Observable
class GoalPageViewModel {
    var modelContext: ModelContext? = nil
    var goalViewModels: [GoalViewModel] = []
    
    
    func fetchGoals() {
        guard let modelContext = self.modelContext else { return }
        
        do {
            let goals = try modelContext.fetch(FetchDescriptor<GoalModel>())
            
            self.goalViewModels = goals.map { GoalViewModel(goal: $0, modelContext: modelContext) }
        } catch {
            print("Failed to fetch goals: \(error)")
            self.goalViewModels = []
        }
    }
    
    func addGoal(goal: GoalModel) {
        guard let modelContext = self.modelContext else { return }
        
        modelContext.insert(goal)
        self.goalViewModels.append(GoalViewModel(goal: goal, modelContext: modelContext))
    }
    
    func removeGoal(goalViewModel: GoalViewModel) {
        goalViewModel.remove()
        self.goalViewModels.removeAll(where: { $0.goal == goalViewModel.goal })
    }
}
