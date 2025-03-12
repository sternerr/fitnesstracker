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
    
    @State private var viewModel: WorkoutViewModel = WorkoutViewModel()
    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationStack {
            if(self.viewModel.workout != nil)  {
                
                Container {
                    Block {
                        TopBar(text: "Add Workout") {
                            Image(systemName: "arrow.backward.square.fill")
                                .font(.system(size: 42))
                                .foregroundStyle(.secondarySurfaceContainer)
                                .onTapGesture {
                                    self.viewModel.remove()
                                    self.selectedTab = 0
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
                            ForEach(self.viewModel.exerciseViewModels) { evm in
                                ExerciseCard(exerciseViewModel: evm, workoutViewModel: self.$viewModel)
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
            
            if(self.viewModel.workout == nil ) {
            
                self.viewModel.addWorkout()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: WorkoutModel.self, inMemory: true)
}
