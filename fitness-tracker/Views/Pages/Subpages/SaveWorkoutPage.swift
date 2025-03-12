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
    @Binding var viewModel: WorkoutViewModel
    
    @State private var text: String = ""
    @State private var date: Date = .now
    
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
                DatePicker("Workout date", selection: $date, displayedComponents: [.date])
                    .datePickerStyle(CompactDatePickerStyle())
                Spacer()
                    .frame(minHeight: 128, maxHeight: 128)
                
                Button(action: {
                    if(!self.text.isEmpty) {
                        self.viewModel.save(
                            name: self.text,
                            state: "saved",
                            date: date.formatted(date: .numeric, time: .omitted)
                        )
                        
                        self.viewModel.addWorkout()
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
