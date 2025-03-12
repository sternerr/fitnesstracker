//
//  HistoryPage-ViewModel.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-12.
//

import SwiftData
import Foundation

extension HistoryPage {
    
    @Observable
    class ViewModel {
        var modelContext: ModelContext? = nil
        var workoutViewModels: [WorkoutViewModel] = []
        
        
        func fetch(byDate date: String) {
            guard let modelContext = self.modelContext else { return }
            
            do {
                let workouts = try modelContext.fetch(FetchDescriptor(predicate: #Predicate<WorkoutModel> {
                    $0.date == date
                }))
                
                self.workoutViewModels = workouts.map { WorkoutViewModel(workout: $0, modelContext: modelContext) }
            } catch {
                print("Failed to fetch workouts: \(error)")
                self.workoutViewModels = []
            }
        }
    }
}
