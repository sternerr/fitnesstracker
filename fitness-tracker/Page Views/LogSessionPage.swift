//
//  LogSession.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-02-13.
//

import SwiftUI

struct LogSessionPage: View {
    @State private var exercises: [Exercise] = [
        Exercise(name: "Pull up"),
        Exercise(name: "Pull down"),
        Exercise(name: "Jump Rope"),
        Exercise(name: "Squats")
    ]
    
    var body: some View {
        Container {
            Block {
                TopBar(text: "Add Workout") {
                    Spacer()
                    NavigationLink(
                        destination: SaveWorkoutPage(exercises: $exercises)
                            .navigationBarHidden(true)
                    ) {
                        CustomButton(title: "Done")
                    }
                }
                
                Block {
                    CustomList {
                        ForEach(exercises.indices, id:\.self) { index in
                            SwipeToDelete(action: {
                                self.exercises.remove(at: index)
                            }) {
                                ExerciseRow(exercise: exercises[index])
                            }
                        }
                        
                        NavigationLink(
                            destination: AddExercisePage(exercises: $exercises)
                                .navigationBarHidden(true)
                        ){
                            CustomButton(title: "Add Exercise")
                        }
                        .padding(.vertical)
                    }
                }
            }
        }
    }
}

#Preview {
    LogSessionPage()
}
