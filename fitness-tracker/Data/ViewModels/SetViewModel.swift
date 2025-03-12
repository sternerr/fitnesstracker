//
//  SetViewModel.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-11.
//

import SwiftData

class SetViewModel: Identifiable {
    var modelContext: ModelContext? = nil
    var set: SetModel? = nil
    
    init(set: SetModel? = nil, modelContext: ModelContext? = nil) {
        self.set = set
        self.modelContext = modelContext
    }
    
    func remove() {
        guard let modelContext = self.modelContext  else { return }
        guard let set = self.set else { return }
        
        modelContext.delete(set)
    }
}
