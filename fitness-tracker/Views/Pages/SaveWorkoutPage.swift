//
//  SaveWorkoutPage.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-02.
//

import SwiftUI
import SwiftData

struct SaveWorkoutPage: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query(filter: #Predicate<WorkoutModel> { workout in
        workout.state == ""
    }) var workouts: [WorkoutModel]
    
    @State private var text: String = ""
    
    var body: some View {
        Container {
            Block {
                TopBar(text: "Save Workout") {
                    Image(systemName: "arrow.backward.square.fill")
                        .resizable()
                        .frame(width: 40.0, height: 40.0)
                        .foregroundStyle(.secondarySurfaceContainer)
                        .onTapGesture { self.dismiss() }
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            Block {
                TextField("Save Workout", text: self.$text) {}
                    .padding()
                    .font(.body)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.secondarySurfaceContainer, lineWidth: 2)
                    )
                
                Spacer()
                    .frame(minHeight: 128, maxHeight: 128)
                
                Button(action: {
                    if(self.workouts.count > 0 && !self.text.isEmpty) {
                        self.workouts[0].name = self.text
                        self.workouts[0].state = "saved"
                        self.dismiss()
                    }
                }) {
                    CustomButton(title: "Save")
                }
            }
            
            Spacer()
        }
    }
}
