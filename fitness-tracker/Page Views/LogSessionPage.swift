//
//  LogSession.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-02-13.
//

import SwiftUI

struct LogSessionPage: View {
    @State private var exercises: [Exercise] = [
        Exercise(name: "Pull up")
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
              
                // Behövs Fixas
                List {
                    ForEach(exercises.indices, id:\.self) { index in
                        ExerciseRow(exercise: exercises[index])
                            .swipeActions {
                                Button(role: .destructive) {
                                    exercises.remove(at: index)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                .tint(.delete)
                            }
                    }
                    
                }
                .padding(-8)
                .scrollContentBackground(.hidden)

                
                NavigationLink(
                    destination: AddExercisePage(exercises: $exercises)
                        .navigationBarHidden(true)
                ){
                    CustomButton(title: "Add Exercise")
                }
                
                Spacer()
            }
            .padding(.bottom)
        }
    }
}

// Behövs Fixas

struct ExerciseRow: View {
    @State var exercise: Exercise
    
    var body: some View {
        HStack {
            Text(exercise.name)
                .padding()
                .cornerRadius(8)
            
            Spacer()
            
            Image(systemName: "plus.app.fill")
                .resizable()
                .frame(width: 40.0, height: 40.0)
                .foregroundStyle(.primary70)
                .tint(.blue)
        }
        .background(
            .secondarySurfaceContainer,
            in: RoundedRectangle(cornerRadius: 8)
        )
    }
}

#Preview {
    LogSessionPage()
}
