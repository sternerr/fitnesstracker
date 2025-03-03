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
    
    func fetchWorkout(byState state: String) {
        self.workouts = (try? self.modelContext?.fetch(FetchDescriptor(predicate: #Predicate<WorkoutModel> {
            $0.state == state
        }))) ?? []
    }
    
    func fetchWorkout(byDate date: String) {
        self.workouts = (try? self.modelContext?.fetch(FetchDescriptor(predicate: #Predicate<WorkoutModel> {
            $0.date == date
        }))) ?? []
    }
    
    func addWorkout() {
        self.modelContext?.insert(WorkoutModel())
        self.fetchWorkout(byState: "")
    }
    
    func addExercise(for workout: WorkoutModel, exercise: ExerciseModel) {
        workout.exercises.append(exercise)
    }
    
    func addSet(for exercise: ExerciseModel, set: SetModel) {
        exercise.sets.append(set)
    }
    
    func removeExercise(for workout: WorkoutModel, exercise: ExerciseModel) {
        workout.exercises.removeAll(where: { $0.id == exercise.id })
    }
    
    func removeSet(for exercise: ExerciseModel, set: SetModel) {
        exercise.sets.removeAll(where: { $0.id == set.id })
    }
}
