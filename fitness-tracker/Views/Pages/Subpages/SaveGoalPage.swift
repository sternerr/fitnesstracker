//
//  SaveGoalPage.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-03-04.
//

import SwiftUI



struct SaveGoalPage: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) private var presentationMode
    @Binding var goals: [Goal]
    
    @State private var goaltext: String = ""
    @State private var descriptiontext: String = ""
    
    
    
    var body: some View {
        Container {
            Block {
                TopBar(text: "Goals") {
                    Image(systemName: "arrow.backward.square.fill")
                        .resizable()
                        .frame(width: 40.0, height: 40.0)
                        .foregroundStyle(.secondarySurfaceContainer)
                        .onTapGesture { dismiss()
                        }
                    Spacer()
                }
            }
            
            Block{
                TextField("Enter Goal", text: $goaltext) {}
                    .padding(8)
                    .font(.body)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.secondarySurfaceContainer, lineWidth: 2))
                
                    .padding(.top, 70)
                
                                
                TextField("Enter Description", text: $descriptiontext) {}
                    .padding(8)
                    .font(.body)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.secondarySurfaceContainer, lineWidth: 2))
                
                    .padding(.top, 40)

                Spacer()

                Button(action: {
                    if !goaltext.isEmpty && !descriptiontext.isEmpty {
                        let newGoal = Goal(title: goaltext, description: descriptiontext)
                        goals.append(newGoal)
                        dismiss()
                    }
                }) {
                    CustomButton(title: "Save")
                    
                }
                
                Spacer()
                
                
            }
            
            Spacer()
        }
    }
    
}
