//
//  LogHistory.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-02-13.
//

import SwiftUI
import SwiftData

struct HistoryPage: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: WorkoutViewModel = WorkoutViewModel()
    
    @State private var date = Date()
    
    var body: some View {
        NavigationStack {
            Container {
                Block {
                    TopBar(text: "History") { Spacer() }
                }
                
                Block {
                    ScrollView {
                        DatePicker("Start Date", selection: $date, displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                            .onChange(of: date, initial: true) {
                                self.viewModel.fetchWorkout(byDate: date.formatted(date: .numeric, time: .omitted))
                            }
                        
                        VStack {
                            ForEach(self.viewModel.workouts) { workout in
                                WorkoutCard(viewModel: self.$viewModel, workout: workout)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                
            }
        }
        .onAppear {
            self.viewModel.modelContext = self.modelContext
            self.viewModel.fetchWorkout(byDate: date.formatted(date: .numeric, time: .omitted))
        }
    }
    
    func sampleData() {
        self.viewModel.addWorkout()
        
        self.viewModel.workouts[0].name = "Workout 1"
        self.viewModel.workouts[0].state = "saved"
        self.viewModel.workouts[0].date = "2025-03-01"
        
        let exercise1 = ExerciseModel(name: "Pull Up")
        let exercise2 = ExerciseModel(name: "Push Up")
        
        self.viewModel.addExercise(for: self.viewModel.workouts[0], exercise: exercise1)
        self.viewModel.addExercise(for: self.viewModel.workouts[0], exercise: exercise2)
        
        self.viewModel.fetchWorkout(byDate: DateToString(date: self.date).result)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: WorkoutModel.self, inMemory: true)
}
