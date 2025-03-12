//
//  WorkoutViewModelTest.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-12.
//

import Testing
@testable import fitness_tracker

struct WorkoutViewModelTest {
    private var viewModels: [WorkoutViewModel] = [
        WorkoutViewModel(workout: WorkoutModel()),
        WorkoutViewModel(workout: WorkoutModel())
    ]

    
    @Test func getExerciseCount() async throws {
        self.sample()
        
        #expect(self.viewModels[0].getExerciseCount() == 1, "Should return 1")
        #expect(self.viewModels[1].getExerciseCount() == 2, "Should return 2")
    }
    
    @Test func getSetCount() async throws {
        self.sample()
        
        #expect(self.viewModels[0].getSetsCount() == 3, "Should return 3")
        #expect(self.viewModels[1].getSetsCount() == 6, "Should return 6")
    }
    
    @Test func getRepsCount() async throws {
        self.sample()
        
        #expect(self.viewModels[0].getRepsCount() == 30, "Should return 30")
        #expect(self.viewModels[1].getRepsCount() == 60, "Should return 60")
    }
    
    @Test func getVolume() async throws {
        self.sample()
        
        #expect(self.viewModels[0].getVolume() == 300, "Should return 1")
        #expect(self.viewModels[1].getVolume() == 450, "Should return 3")
    }
    
    private func sample()  {
        self.viewModels[0].workout?.exercises.append(ExerciseModel(name: "Pull Ups"))
        self.viewModels[0].workout?.exercises[0].sets.append(SetModel(reps: 12, weight: 10))
        self.viewModels[0].workout?.exercises[0].sets.append(SetModel(reps: 10, weight: 10))
        self.viewModels[0].workout?.exercises[0].sets.append(SetModel(reps: 8, weight: 10))
        
        self.viewModels[1].workout?.exercises.append(ExerciseModel(name: "Pull Ups"))
        self.viewModels[1].workout?.exercises[0].sets.append(SetModel(reps: 12, weight: 10))
        self.viewModels[1].workout?.exercises[0].sets.append(SetModel(reps: 10, weight: 10))
        self.viewModels[1].workout?.exercises[0].sets.append(SetModel(reps: 8, weight: 10))
        
        self.viewModels[1].workout?.exercises.append(ExerciseModel(name: "Push Ups"))
        self.viewModels[1].workout?.exercises[1].sets.append(SetModel(reps: 12, weight: 5))
        self.viewModels[1].workout?.exercises[1].sets.append(SetModel(reps: 10, weight: 5))
        self.viewModels[1].workout?.exercises[1].sets.append(SetModel(reps: 8, weight: 5))
    }
}
