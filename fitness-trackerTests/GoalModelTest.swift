//
//  GoalModelTest.swift
//  fitness-trackerTests
//
//  Created by Maria Garic on 2025-03-10.
//

import Testing
import Foundation
@testable import fitness_tracker

struct GoalModelTest {
    @Test func testTotalSum() async throws {
        let goalModel = GoalModel(id: UUID(), title: "Test", goalDescription: "Test", setsAmount: "5", repsAmount: "8", volumeAmount: "10")
        #expect(400.0 == goalModel.totalSum, "Expect to be 400")
    }
}

