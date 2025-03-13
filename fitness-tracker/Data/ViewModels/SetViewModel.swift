//
//  SetViewModel.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-11.
//

import SwiftData

class SetViewModel: Identifiable {
    var modelContext: ModelContext? = nil
    var set: SetModel
    
    init(set: SetModel, modelContext: ModelContext? = nil) {
        self.set = set
        self.modelContext = modelContext
    }
    
    func remove() {
        guard let modelContext = self.modelContext  else { return }
        
        modelContext.delete(set)
    }
    
    func setWeight(value: Int) {
        self.set.weight = value
    }
    
    func setReps(value: Int) {
        self.set.reps = value
    }
}
