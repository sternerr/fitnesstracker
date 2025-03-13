//
//  SaveGoalPage.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-03-04.
//

import SwiftUI

struct SaveGoalPage: View {
    @Environment(\.dismiss) var dismiss

    @Binding var viewModel: GoalPageViewModel
    @Binding var goalViewModel: GoalViewModel?
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var amount: String = ""
    @State private var exercise: String = ""
    
    @State private var selectedMeasurement: MeasurementType = .weight
    
    enum MeasurementType: String, CaseIterable, Identifiable {
//        case reps = "reps"
        case weight = "weight"
        
        var id: String { self.rawValue }
    }
    
    var isValid: Bool {
        (!title.isEmpty && !description.isEmpty && amount != "") ||
        (!title.isEmpty && !description.isEmpty && amount != "")
    }
    
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
                TextField("Enter Goal", text: $title)
                    .padding(8)
                    .font(.body)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.secondarySurfaceContainer, lineWidth: 2))
                
                    .padding(.top, 70)
                
                TextField("Enter Description", text: $description)
                    .padding(8)
                    .font(.body)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.secondarySurfaceContainer, lineWidth: 2))
                
                    .padding(.top, 40)
                
                Picker("Select Measurement", selection: $selectedMeasurement) {
                    ForEach(MeasurementType.allCases) { measurement in
                        Text(measurement.rawValue).tag(measurement)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.top, 20)
                
                TextField("Enter Amount", text: self.$amount)
                    .padding(8)
                    .font(.body)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.secondarySurfaceContainer, lineWidth: 2)
                    )
                    .padding(.top, 40)
                    .keyboardType(.numberPad)
            }

            List {
                NavigationLink {
                    AddExercisePage2(exercise: self.$exercise)
                } label: {
                    Text("Choose Exercise")
                        .padding(.vertical)
                }
                
                if(!self.exercise.isEmpty) {
                    Text(self.exercise)
                }
            }
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            
            Spacer()
            
            Button(action: {
                if(self.isValid) {
                    if(self.goalViewModel != nil) {
                        self.goalViewModel!.save(title: title, description: description, amount: Int(amount), exercise: exercise)
                    } else {
                        self.viewModel.addGoal(goal:
                            GoalModel(title: self.title, goalDescription: self.description, amount: Int(self.amount)!, measurement: self.selectedMeasurement.rawValue, exercise: exercise)
                        )
                    }
                    
                    self.dismiss()
                }
            }) {
                CustomButton(title: "Save")
            }
            .opacity(isValid ? 1 : 0.5)
            
            Spacer()
            
        }
        .onAppear {
            if(self.goalViewModel != nil) {
                self.title = self.goalViewModel!.goal.title
                self.description = self.goalViewModel!.goal.goalDescription
                self.amount = String(self.goalViewModel!.goal.amount)
                self.exercise = self.goalViewModel!.goal.exercise
            }
        }
    }
}

