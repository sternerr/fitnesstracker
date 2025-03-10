//
//  LogSession.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-02-13.
//

import SwiftUI
import SwiftData

struct AddWorkoutPage: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = WorkoutViewModel()
    
    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationStack {
            if(self.viewModel.workouts.count > 0)  {
                
                Container {
                    Block {
                        TopBar(text: "Add Workout") {
                            Image(systemName: "arrow.backward.square.fill")
                                .font(.system(size: 42))
                                .foregroundStyle(.secondarySurfaceContainer)
                                .onTapGesture {
                                    self.viewModel.removeWorkout(workout: self.viewModel.workouts[0])
                                    self.selectedTab = 0
                                    
                                    self.viewModel.addWorkout()
                                }
                            
                            Spacer()
                            
                            NavigationLink(
                                destination: SaveWorkoutPage(viewModel: self.$viewModel)
                                    .navigationBarHidden(true)
                            ) {
                                CustomButton(title: "Done")
                            }
                        }
                        
                    }
                    
                    Block {
                        ScrollView {
                            ForEach(self.viewModel.workouts[0].exercises, id: \.self) { exercise in
                                ExerciseCard(viewModel: self.$viewModel, exercise: exercise)
                            }
                        }
                        
                        NavigationLink(
                            destination: AddExercisePage(viewModel: self.$viewModel)
                                .navigationBarHidden(true)
                        ){
                            CustomButton(title: "Add Exercise")
                        }
                        .padding(.vertical)
                    }
                }
            }
        }
        .onAppear {
            self.viewModel.modelContext = self.modelContext
            
            if(self.viewModel.workouts.count <= 0 ) {
                self.viewModel.addWorkout()
            }
        }
    }
    
    func sampleData() {
        let exercise1 = ExerciseModel(name: "Pull Up")
        let exercise2 = ExerciseModel(name: "Pull Up")
        
        self.viewModel.addExercise(for: self.viewModel.workouts[0], exercise: exercise1)
        self.viewModel.addExercise(for: self.viewModel.workouts[0], exercise: exercise2)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: WorkoutModel.self, inMemory: true)
}
