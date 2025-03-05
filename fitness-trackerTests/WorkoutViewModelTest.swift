//
//  Test.swift
//  fitness-trackerTests
//
//  Created by Noah Sterner on 2025-03-05.
//

import Testing
@testable import fitness_tracker

struct WorkoutViewModelTest {
    private var viewModel: WorkoutViewModel = WorkoutViewModel()
    private var workouts: [WorkoutModel] = [
        WorkoutModel(name: "test 1", state: "saved"),
        WorkoutModel(name: "test 2", state: "saved")
    ]
    
    @Test func getExerciseCount() async throws {
        self.sample()
        
        #expect(self.viewModel.getExerciseCount(for: self.workouts[0]) == 1, "Should return 1")
        #expect(self.viewModel.getExerciseCount(for: self.workouts[1]) == 2, "Should return 2")
    }
    
    @Test func getSetCount() async throws {
        self.sample()
        
        #expect(self.viewModel.getSetsCount(for: self.workouts[0]) == 3, "Should return 3")
        #expect(self.viewModel.getSetsCount(for: self.workouts[1]) == 6, "Should return 6")
    }
    
    @Test func getRepsCount() async throws {
        self.sample()
        
        #expect(self.viewModel.getRepsCount(for: self.workouts[0]) == 30, "Should return 30")
        #expect(self.viewModel.getRepsCount(for: self.workouts[1]) == 60, "Should return 60")
    }
    
    @Test func getVolume() async throws {
        self.sample()
        
        #expect(self.viewModel.getVolume(for: self.workouts[0]) == 300, "Should return 1")
        #expect(self.viewModel.getVolume(for: self.workouts[1]) == 450, "Should return 3")
    }
    
    private func sample()  {
        self.workouts[0].exercises.append(ExerciseModel(
            name: "Pull Ups",
            sets: [SetModel(reps: 12, weight: 10), SetModel(reps: 10, weight: 10), SetModel(reps: 8, weight: 10)]
        ))
        
        self.workouts[1].exercises.append(ExerciseModel(
            name: "Pull Ups",
            sets: [SetModel(reps: 12, weight: 10), SetModel(reps: 10, weight: 10), SetModel(reps: 8, weight: 10)]
        ))
                   
        self.workouts[1].exercises.append(ExerciseModel(
            name: "Push Ups",
            sets: [SetModel(reps: 12, weight: 5), SetModel(reps: 10, weight: 5), SetModel(reps: 8, weight: 5)]
        ))
    }
}
