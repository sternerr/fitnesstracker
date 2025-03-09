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
}
