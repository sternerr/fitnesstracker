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
    var sets: [SetViewModel] = []
    
    func add(set: SetModel) {
        let newSetWM = SetViewModel()
        newSetWM.modelContext = self.modelContext
        newSetWM.set = set
        
        
        self.exercise?.sets.append(set)
        self.sets.append(newSetWM)
    }
    
    func remove() {
        guard self.exercise != nil else { return }
        self.modelContext?.delete(self.exercise!)
    }
    
    func remove(setViewModel: SetViewModel) {
        setViewModel.remove()
        self.sets.removeAll(where: { $0.set?.id == setViewModel.set?.id })
    }
}
