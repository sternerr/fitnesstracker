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
    var workout: WorkoutModel? = nil
    var exercises: [ExerciseViewModel] = []
    
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
        
        self.workout = (try? self.modelContext?.fetch(FetchDescriptor(predicate: #Predicate<WorkoutModel> {
            $0.state == ""
        })))?.first ?? nil
    }
    
    func addExercise(exercise: ExerciseModel) {
        let newExercieVM = ExerciseViewModel()
        newExercieVM.modelContext = self.modelContext
        newExercieVM.exercise = exercise
        
        
        self.workout?.exercises.append(exercise)
        self.exercises.append(newExercieVM)
    }
    
    func addSet(for exercise: ExerciseModel, set: SetModel) {
        exercise.sets.append(set)
    }
    
    func saveWorkout(for workout: WorkoutModel, name: String?, state: String?, date: String?) {
        workout.name = name ?? workout.name
        workout.state = state ?? workout.state
        workout.date = date ?? workout.date
    }
    
    func remove() {
        guard self.workout != nil else { return }
        
        self.modelContext?.delete(self.workout!)
        self.workout = (try? self.modelContext?.fetch(FetchDescriptor(predicate: #Predicate<WorkoutModel> {
            $0.state == ""
        })))?.first ?? nil
        self.exercises = []
    }
        
    func remove(evm: ExerciseViewModel) {
        evm.remove()
        self.exercises.removeAll(where: { $0.exercise?.id == evm.exercise?.id })
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
