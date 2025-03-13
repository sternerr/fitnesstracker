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
    var exerciseViewModels: [ExerciseViewModel] = []
    
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
    
    func fetchExercises() {
        guard let modelContext = self.modelContext else { return }
        
        do {
            let exercises = try modelContext.fetch(FetchDescriptor<ExerciseModel>())
            
            self.exerciseViewModels = exercises.map { ExerciseViewModel(exercise: $0, modelContext: modelContext) }
        } catch {
            print("Failed to fetch exercises: \(error)")
            self.exerciseViewModels = []
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
    
    func weightProgress(gvm: GoalViewModel) -> Double {
        let res = self.exerciseViewModels.filter { evm in
            evm.exercise!.name.localizedCaseInsensitiveContains(gvm.goal.exercise)
        }
        
        var total: Int = 0
        res.forEach {
            $0.exercise?.sets.forEach {
                if($0.weight > total) {
                    total = $0.weight
                }
            }
        }
        
        return Double(total) / Double(gvm.goal.amount)
    }
}
