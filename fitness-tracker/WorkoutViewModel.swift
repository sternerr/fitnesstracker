//
//  WorkoutViewModel.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-03.
//

import SwiftData
import SwiftUI
import Observation

@Observable
class WorkoutViewModel {
    var modelContext: ModelContext? = nil
    var workouts: [WorkoutModel] = []
    
    func fetchNewWorkout() {
        self.workouts = (try? self.modelContext?.fetch(FetchDescriptor(predicate: #Predicate<WorkoutModel> {
            $0.state == ""
        }))) ?? []
    }
    
    func addWorkout() {
        self.modelContext?.insert(WorkoutModel())
        self.fetchNewWorkout()
    }
    
    func addExercise(for workout: WorkoutModel, exercise: ExerciseModel) {
        workout.exercises.append(exercise)
    }
}
