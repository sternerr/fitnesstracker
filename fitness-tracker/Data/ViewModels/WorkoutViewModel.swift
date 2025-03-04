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
        print (self.workouts)
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
        let newWorkout = WorkoutModel ()
        newWorkout.name = name ?? ""
        newWorkout.state = state ?? ""
        newWorkout.date = date ?? ""
        workouts.append(newWorkout)
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
    
    func getExerciseCount(for workout: WorkoutModel) -> Int {
        return workout.exercises.count
    }
    
    func getSetsCount(for workout: WorkoutModel) -> Int {
        var count: Int = 0
        
        workout.exercises.forEach {
            count += $0.sets.count
        }
        
        return count
    }
    
    func getRepsCount(for workout: WorkoutModel) -> Int {
        var count: Int = 0
        
        workout.exercises.forEach {
            $0.sets.forEach {
                count += Int($0.reps)
            }
        }
        
        return count
    }
    
    func getVolume(for workout: WorkoutModel) -> Int {
        var volume: Int = 0
        
        workout.exercises.forEach {
            $0.sets.forEach {
                volume += Int($0.reps) * (Int($0.weight) == 0 ? 1 : Int($0.weight))
            }
        }

        return volume
    }
}
