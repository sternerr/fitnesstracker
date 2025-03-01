//
//  LogSession.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-02-13.
//

import SwiftUI
import SwiftData

//SwiftData need to be itergrated, and some views need to be in different files for readability

struct LogSessionPage: View {
    @State private var workout: WorkoutModel = WorkoutModel()
    	
    var body: some View {
        NavigationStack {
            Container {
                Block {
                    TopBar(text: "Add Workout") {
                        Spacer()
                        NavigationLink(
                            destination: SaveWorkoutPage(workout: $workout)
                                .navigationBarHidden(true)
                        ) {
                            CustomButton(title: "Done")
                        }
                    }
                    
                }
                
                Block {
                    ScrollView {
                        ForEach(workout.exercises, id:\.self) { exercise in
                            SwipeToDelete(action: {
                                print("Delete Exercise")
                            }) {
                                ExerciseCard(exercise: exercise)
                            }
                        }
                        
                        NavigationLink(
                            destination: AddExercisePage(workout: workout)
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

struct ExerciseCard: View {
    var exercise: ExerciseModel
    
    var body: some View {
        VStack {
            HStack {
                Text(exercise.name)
                    .font(.system(size: 20))
                Spacer()
                Button {
                    print("Add Set")
                    exercise.sets.append(SetModel())
                } label: {
                    Image(systemName: "plus.app.fill")
                        .font(.system(size: 32))
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal)
            
            ForEach(exercise.sets.indices, id: \.self) { index in
                SwipeToDelete(action: {
                    print("delete Set")
                }) {
                    SetView(set: exercise.sets[index], index: index)
                }
            }
        }
        .padding()
        .background(.secondarySurfaceContainer)
    }
}

struct SetView: View {
    @State var set: SetModel
    @State var index: Int
    
    @State private var repsText: String = ""
    @State private var weightText: String = ""
    
    var body: some View {
        HStack {
            Text("\(index + 1)")
            Spacer()
            InputField(type: .Reps, text: $repsText)
            Spacer()
            InputField(type: .Weight, text: $weightText)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 32)
        .background(.secondarySurfaceContainer)
    }
    
    enum InputType {
        case Reps
        case Weight
    }
    
    @ViewBuilder
    func InputField(type: InputType, text: Binding<String>) -> some View {
        HStack {
            TextField("0", text: text)
                .multilineTextAlignment(.trailing)
                .onChange(of: text.wrappedValue, initial: false) { (oldState, newState) in
                    if(type == .Weight) {
                        if let value = Int(newState) {
                            set.weight = Int(value)
                        }
                    } else {
                        if let value = Int(newState) {
                            set.reps = Int(value)
                        }
                    }
                }
            Text("Reps")
        }
    }
}

struct AddExercisePage: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var workout: WorkoutModel
    @State private var text: String = ""
    
    var body: some View {
        Container {
            Block {
                TopBar(text: "") {
                    Image(systemName: "arrow.backward.square.fill")
                        .resizable()
                        .frame(width: 40.0, height: 40.0)
                        .foregroundStyle(.secondarySurfaceContainer)
                        .onTapGesture { dismiss() }
                    
                    
                    TextField("Enter Exercise", text: $text) {}
                        .padding(8)
                        .font(.body)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.secondarySurfaceContainer, lineWidth: 2)
                        )
                }
                
                Button{
                    addExercise()
                    dismiss()
                } label: {
                    CustomButton(title: "Create Exercise")
                }
                
                Spacer()
            }
        }
    }
    
    func addExercise() {
        let exercise = ExerciseModel(name: text)
        workout.exercises.append(exercise)
    }
}

struct SaveWorkoutPage: View {
    @Environment(\.dismiss) private var dismiss

    @State private var text: String = ""
    @Binding var workout: WorkoutModel
    
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
                        workout = WorkoutModel()
                        dismiss()
                    }
                }) {
                    CustomButton(title: "Save")
                }
            }
            
            Spacer()
        }
    }
}
#Preview {
    LogSessionPage()
}
