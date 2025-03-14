//
//  Dashbord-ViewModel.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-13.
//

import SwiftData
import CoreData

extension Dashboard {
    
    @Observable
    class ViewModel {
        var modelContext: ModelContext? = nil
        var goalViewModels: [GoalViewModel] = []
        var exerciseViewModels: [ExerciseViewModel] = []
        var workoutViewModels: [WorkoutViewModel] = []

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
        
        func fetchWorkout() {
            guard let modelContext = self.modelContext else { return }
            
            do {
                let workouts = try modelContext.fetch(FetchDescriptor<WorkoutModel>(
                    sortBy: [SortDescriptor(\WorkoutModel.date)]
                ))
                
                self.workoutViewModels = workouts.map { WorkoutViewModel(workout: $0, modelContext: modelContext) }
            } catch {
                print("Failed to fetch exercises: \(error)")
                self.exerciseViewModels = []
            }
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
}
