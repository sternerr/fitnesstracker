//
//  ExerciseVIewModelTest.swift
//  fitness-trackerTests
//
//  Created by Noah Sterner on 2025-03-04.
//

import Testing
@testable import fitness_tracker

struct ExerciseViewModelTest {
    private var viewModel: ExerciseViewModel = ExerciseViewModel()
    
    @Test func filterTest() async throws {
        self.viewModel.exercises.append(ExerciseModel(name: "Pull Up"))
        self.viewModel.exercises.append(ExerciseModel(name: "Push Up"))
        self.viewModel.exercises.append(ExerciseModel(name: "Squats"))
        
        print(self.viewModel.exercises)
        let res1 = self.viewModel.filterExercises(exercises: self.viewModel.exercises, filter: "")
        let res2 = self.viewModel.filterExercises(exercises: self.viewModel.exercises, filter: "pu")
        let res3 = self.viewModel.filterExercises(exercises: self.viewModel.exercises, filter: "push up")
        
        #expect(res1.count == 3)
        #expect(res2.count == 2)
        #expect((res3.count == 1 && res3[0].name == "Push Up"))
    }

}
