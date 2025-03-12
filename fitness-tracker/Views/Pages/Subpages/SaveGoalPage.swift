//
//  SaveGoalPage.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-03-04.
//

import SwiftUI
import Combine

struct SaveGoalPage: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) private var presentationMode

    var viewModel: GoalViewModel
    @Binding var selectedGoal: GoalModel?
    
    @State private var goalText: String = ""
    @State private var goalDescription: String = ""
    @State private var setsAmount: String = ""
    @State private var repsAmount: String = ""
    @State private var volumeAmount: String = ""
    
    @State private var selectedMeasurement: MeasurementType = .sets
    
    let mode: Mode
    
    enum Mode {
        case add, edit
    }
    
    enum MeasurementType: String, CaseIterable, Identifiable {
        case sets = "Sets"
        case reps = "Reps"
        case volume = "Volume"
        
        var id: String { self.rawValue }
    }
    
    var isValid:  Bool {
        //Case 1
        (!goalText.isEmpty && !goalDescription.isEmpty && !setsAmount.isEmpty && !repsAmount.isEmpty && !volumeAmount.isEmpty) ||
        //Case 2
        (!goalText.isEmpty && !goalDescription.isEmpty && setsAmount.isEmpty && repsAmount.isEmpty && volumeAmount.isEmpty)
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
                TextField("Enter Goal", text: $goalText) {}
                    .padding(8)
                    .font(.body)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.secondarySurfaceContainer, lineWidth: 2))
                
                    .padding(.top, 70)
                
                
                TextField("Enter Description", text: $goalDescription) {}
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
                
                Group {
                    switch selectedMeasurement {
                    case .sets:
                        TextField("Enter amount of sets", text: $setsAmount)
                            .keyboardType(.numberPad)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.top, 20)
                            .onReceive(Just(setsAmount)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.setsAmount = filtered
                                }
                            }
                    case .reps:
                        TextField("Enter amount of reps", text: $repsAmount)
                            .keyboardType(.numberPad)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.top, 20)
                            .onReceive(Just(repsAmount)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.repsAmount = filtered
                                }
                            }
                    case .volume:
                        TextField("Enter amount of volume", text: $volumeAmount)
                            .keyboardType(.decimalPad)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.top, 20)
                            .onReceive(Just(volumeAmount)) { newValue in
                                let filtered = newValue.filter { "0123456789.".contains($0) }
                                if filtered != newValue {
                                    self.volumeAmount = filtered
                                }
                            }
                    }
                }
                Spacer()
                
                Button(action: {
                    if mode == .add {
                        if isValid {
                            viewModel.addGoal(title: goalText, description: goalDescription, setsAmount: setsAmount, repsAmount: repsAmount, volumeAmount: volumeAmount)
                            dismiss()
                        } else {
                            
                        }
                    }
                    
                    if mode == .edit {
                        if isValid {
                            viewModel.editGoal(goal: selectedGoal, title: goalText, description: goalDescription, setsAmount: setsAmount, repsAmount: repsAmount, volumeAmount: volumeAmount)
                            dismiss()
                        } else {
                            
                        }
                    }
                }) {
                    CustomButton(title: "Save")
                }
                .opacity(isValid ? 1 : 0.5)
                
                Spacer()
                
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
        .onAppear {
            goalText = selectedGoal?.title ?? ""
            goalDescription = selectedGoal?.goalDescription ?? ""
            setsAmount = selectedGoal?.setsAmount ?? ""
            repsAmount = selectedGoal?.repsAmount ?? ""
            volumeAmount = selectedGoal?.volumeAmount ?? ""
        }
    }
    
}

#Preview {
    SaveGoalPage(viewModel: GoalViewModel(), selectedGoal: .constant(nil), mode: .add)
}
