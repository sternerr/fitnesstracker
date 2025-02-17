//
//  SaveExercisePage.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-02-17.
//

import SwiftUI

struct SaveWorkoutPage: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.dismiss) private var dismiss
    
    @Binding var exercises: [Exercise]

    @State private var text: String = ""
    
    var body: some View {
        Container {
            Block {
                TopBar(text: "Save Workout") {
                    Image(systemName: "arrow.backward.square.fill")
                        .resizable()
                        .frame(width: 40.0, height: 40.0)
                        .foregroundStyle(.secondarySurfaceContainer)
                        .onTapGesture { dismiss() }
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            Block {
                TextField("Save Workout", text: $text) {}
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
                    if !text.isEmpty {
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    CustomButton(title: "Save")
                }
            }
            
            Spacer()
        }
    }
}
