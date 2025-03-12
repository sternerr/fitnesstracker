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
class ExerciseViewModel: Identifiable {
    var modelContext: ModelContext? = nil
    var exercise: ExerciseModel? = nil
    var setViewModels: [SetViewModel] = []
   
    init(exercise: ExerciseModel? = nil, modelContext: ModelContext? = nil) {
        self.exercise = exercise
        self.modelContext = modelContext
    }
    
    func fetchSets() {
        guard let modelContext = self.modelContext else { return }
        guard let exercise = self.exercise else { return }
        
        self.setViewModels = exercise.sets.map {
            SetViewModel(set: $0, modelContext: modelContext)
        }
    }
    
    func add(set: SetModel) {
        let newSetWM = SetViewModel()
        newSetWM.modelContext = self.modelContext
        newSetWM.set = set
        
        
        self.exercise?.sets.append(set)
        self.setViewModels.append(newSetWM)
    }
    
    func remove() {
        guard self.exercise != nil else { return }
        self.modelContext?.delete(self.exercise!)
    }
    
    func remove(setViewModel: SetViewModel) {
        setViewModel.remove()
        self.setViewModels.removeAll(where: { $0.set?.id == setViewModel.set?.id })
    }
}
