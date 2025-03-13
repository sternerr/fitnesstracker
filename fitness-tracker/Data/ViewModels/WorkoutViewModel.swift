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
    var workout: WorkoutModel?
    var exerciseViewModels: [ExerciseViewModel] = []
        
    init(workout: WorkoutModel? = nil, modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
        self.workout = workout
    }
    
    func fetchExercises() {
        guard let modelContext = self.modelContext else { return }
        guard let workout = self.workout else { return }
        
        self.exerciseViewModels = workout.exercises.map {
            ExerciseViewModel(exercise: $0, modelContext: modelContext)
        }
    }

    func addWorkout() {
        self.modelContext?.insert(WorkoutModel())
        
        self.workout = (try? self.modelContext?.fetch(FetchDescriptor(predicate: #Predicate<WorkoutModel> {
            $0.state == ""
        })))!.first!
    }
    
    func add(exercise: ExerciseModel) {
        guard let workout = self.workout else { return }
        
        let newExercieVM = ExerciseViewModel()
        newExercieVM.modelContext = self.modelContext
        newExercieVM.exercise = exercise
        
        
        workout.exercises.append(exercise)
        self.exerciseViewModels.append(newExercieVM)
    }
    
    func save(name: String?, state: String?, date: String?) {
        guard let workout = self.workout else { return }
        
        workout.name = name ?? workout.name
        workout.state = state ?? workout.state
        workout.date = date ?? workout.date
    }
    
    func remove() {
        guard let workout = self.workout else { return }
        self.modelContext?.delete(workout)

        self.workout = (try? self.modelContext?.fetch(FetchDescriptor(predicate: #Predicate<WorkoutModel> {
            $0.state == ""
        })))!.first!
        self.exerciseViewModels = []
    }
        
    func remove(exerciseViewModel: ExerciseViewModel) {
        exerciseViewModel.remove()
        self.exerciseViewModels.removeAll(where: { $0.exercise?.id == exerciseViewModel.exercise?.id })
    }
    
    func getExerciseCount() -> Int {
        return workout!.exercises.count
    }
    
    func getSetsCount() -> Int {
        var count: Int = 0
        
        workout!.exercises.forEach {
            count += $0.sets.count
        }
        
        return count
    }
    
    func getRepsCount() -> Int {
        var count: Int = 0
        
        workout!.exercises.forEach {
            $0.sets.forEach {
                count += Int($0.reps)
            }
        }
        
        return count
    }
    
    func getVolume() -> Int {
        var volume: Int = 0
        
        workout!.exercises.forEach {
            $0.sets.forEach {
                volume += Int($0.reps) * (Int($0.weight) == 0 ? 1 : Int($0.weight))
            }
        }

        return volume
    }
}
