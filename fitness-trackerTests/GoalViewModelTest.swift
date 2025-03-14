//
//  GoalModelTest.swift
//  fitness-trackerTests
//
//  Created by Maria Garic on 2025-03-10.
//

import Testing
@testable import fitness_tracker

struct GoalViewModelTest {
    private var viewModel: GoalPageViewModel = GoalPageViewModel()
    private var gvm = GoalViewModel(goal: GoalModel(title: "Goal 1", goalDescription: "Desc 1", amount: 20, measurement: "weight", exercise: "Chin-Up"))

    @Test func testTotalSum() {
        self.sample()
        #expect(self.viewModel.weightProgress(gvm: gvm) == 0.5, "Should return 0.5")
    }
    
    func sample() {
        self.viewModel.exerciseViewModels.append(
            ExerciseViewModel(exercise: ExerciseModel(name: "Chin-Up", sets: [
                SetModel(reps: 10, weight: 10),
                SetModel(reps: 9, weight: 7),
                SetModel(reps: 6, weight: 9)
            ]))
        )
    }
}

