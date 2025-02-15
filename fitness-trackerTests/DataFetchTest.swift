//
//  dataFetchTest.swift
//  fitness-trackerTests
//
//  Created by Noah Sterner on 2025-02-15.
//

import XCTest
@testable import fitness_tracker

final class APIServiceTest: XCTestCase {
    func testExerciseAPICall() async {
        let apiService = APIService.shared
        let expectedNames = [
            "Rickshaw Carry", "Single-Leg Press", "Landmine twist", "Weighted pull-up",
            "T-Bar Row with Handle", "Palms-down wrist curl over bench", "Atlas Stones",
            "Dumbbell front raise to lateral raise", "Clean from Blocks", "Incline Hammer Curls"
        ]
        
        
        let exercises = await apiService.fetchExercises()
        print(exercises)
        
        //Then (Assert)
        XCTAssertFalse(exercises.isEmpty, "The exercises list should not be empty.")
        
        for (index, exercise) in exercises.enumerated() {
            XCTAssertEqual(exercise.name, expectedNames[index], "The exercise name should match the expected value.")
        }
    }
}
