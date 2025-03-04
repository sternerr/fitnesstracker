//
//  ExerciseViewModel.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-04.
//

import Observation
import SwiftData
import Foundation

@Observable
class ExerciseViewModel {
    var modelContext: ModelContext? = nil
    var exercises: [ExerciseModel] = []
   
    func fetchExercise() {
        self.exercises = (try? self.modelContext?.fetch(FetchDescriptor(predicate: #Predicate<ExerciseModel> {
            $0.workout == nil
        }))) ?? []
    }
    
    func filterExercises(exercises: [ExerciseModel], filter: String) -> [ExerciseModel] {
        if(filter.isEmpty) {
            return exercises
        }
        
        return exercises.filter {
            $0.name.contains(filter)
        }
    }
}
