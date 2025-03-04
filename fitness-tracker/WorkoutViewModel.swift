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
    
    func saveWorkout(for workout: WorkoutModel, name: String?, state: String?, date: String?) {
        workout.name = name ?? workout.name
        workout.state = state ?? workout.state
        workout.date = date ?? workout.date
    }
    
    func removeWorkout(workout: WorkoutModel) {
        self.workouts.removeAll(where: { $0.id == workout.id })
    }

    func removeExercise(for workout: WorkoutModel, exercise: ExerciseModel) {
        workout.exercises.removeAll(where: { $0.id == exercise.id })
        self.modelContext?.delete(exercise)
    }
    
    func removeSet(for exercise: ExerciseModel, set: SetModel) {
        exercise.sets.removeAll(where: { $0.id == set.id })
        self.modelContext?.delete(set)
    }
}
