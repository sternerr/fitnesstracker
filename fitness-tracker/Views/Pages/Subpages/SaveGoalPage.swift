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
    @Binding var goals: [Goal]
    @Binding var selectedGoal: Goal?
    
    @State private var goaltext: String = ""
    @State private var descriptiontext: String = ""
    @State private var setsAmount: String = ""
    @State private var repsAmount: String = ""
    @State private var volumeAmount: String = ""
    
    @State private var selectedMeasurement: MeasurementType = .sets
    
    enum MeasurementType: String, CaseIterable, Identifiable {
        case sets = "Sets"
        case reps = "Reps"
        case volume = "Volume"
        
        var id: String { self.rawValue }
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
                            .keyboardType(.decimalPad)
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
        
        .onAppear {
            goaltext = selectedGoal?.title ?? ""
            descriptiontext = selectedGoal?.description ?? ""
        }
    }
    
}

#Preview {
    SaveGoalPage(goals: .constant([.init(title: "title", description: "description")]), selectedGoal: .constant(nil))}
