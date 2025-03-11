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
    
    func remove() {
        guard self.set != nil else { return }
        self.modelContext?.delete(self.set!)
    }
}
