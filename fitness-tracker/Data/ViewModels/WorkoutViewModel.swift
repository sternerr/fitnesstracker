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
class WorkoutViewModel: Identifiable {
    var modelContext: ModelContext? = nil
    var workouts: [WorkoutModel] = []
    var workout: WorkoutModel?
    var exerciseViewModels: [ExerciseViewModel] = []
        
    init(workout: WorkoutModel? = nil, modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
        self.workout = workout
    }
    
    func fetchWorkout(byState state: String) {
        self.workouts = (try? self.modelContext?.fetch(FetchDescriptor(predicate: #Predicate<WorkoutModel> {
            $0.state == state
        }))) ?? []
    }
    
    func addWorkout() {
        self.modelContext?.insert(WorkoutModel())
        
        self.workout = (try? self.modelContext?.fetch(FetchDescriptor(predicate: #Predicate<WorkoutModel> {
            $0.state == ""
        })))?.first ?? nil
    }
    
    func add(exercise: ExerciseModel) {
        let newExercieVM = ExerciseViewModel()
        newExercieVM.modelContext = self.modelContext
        newExercieVM.exercise = exercise
        
        
        self.workout?.exercises.append(exercise)
        self.exerciseViewModels.append(newExercieVM)
    }
    
    func save(name: String?, state: String?, date: String?) {
        guard self.workout != nil else { return }
        
        self.workout!.name = name ?? self.workout!.name
        self.workout!.state = state ?? self.workout!.state
        self.workout!.date = date ?? self.workout!.date
    }
    
    func remove() {
        guard self.workout != nil else { return }
        
        self.modelContext?.delete(self.workout!)
        self.workout = (try? self.modelContext?.fetch(FetchDescriptor(predicate: #Predicate<WorkoutModel> {
            $0.state == ""
        })))?.first ?? nil
        self.exerciseViewModels = []
    }
        
    func remove(exerciseViewModel: ExerciseViewModel) {
        exerciseViewModel.remove()
        self.exerciseViewModels.removeAll(where: { $0.exercise?.id == exerciseViewModel.exercise?.id })
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
