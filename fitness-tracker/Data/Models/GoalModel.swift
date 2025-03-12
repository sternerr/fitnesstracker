//
//  GoalModel.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-03-09.
//

import SwiftData
import Foundation

@Model

class GoalModel: Identifiable, Hashable {
    var id: UUID
    var title: String
    var goalDescription: String
    

    
    var setsAmount: String?
    var repsAmount: String?
    var volumeAmount: String?
    
    init(id: UUID = UUID(), title: String, goalDescription: String, setsAmount: String? = nil, repsAmount: String? = nil, volumeAmount: String? = nil) {
        self.id = id
        self.title = title
        self.goalDescription = goalDescription
        self.setsAmount = setsAmount
        self.repsAmount = repsAmount
        self.volumeAmount = volumeAmount
    }
}
