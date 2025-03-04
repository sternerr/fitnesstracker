//
//  AddExercisePage.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-02.
//

import SwiftUI
import SwiftData

struct AddExercisePage: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var viewModel: WorkoutViewModel
    
    @State private var text: String = ""
    
    @Query(filter: #Predicate<ExerciseModel> {
        $0.workout == nil
    }) private var exercises: [ExerciseModel]
    
    var body: some View {
        Container {
            Block {
                TopBar(text: "") {
                    Image(systemName: "arrow.backward.square.fill")
                        .resizable()
                        .frame(width: 40.0, height: 40.0)
                        .foregroundStyle(.secondarySurfaceContainer)
                        .onTapGesture { self.dismiss() }
                    
                    
                    TextField("Enter Exercise", text: $text) {}
                        .padding(8)
                        .font(.body)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.secondarySurfaceContainer, lineWidth: 2)
                        )
                }
                
                if(self.filterExercises(exercises: self.exercises, filter: self.text).count <= 0) {
                    Button {
                        if(!text.isEmpty) {
                            let exercise = ExerciseModel(name: text)
                            self.viewModel.addExercise(for: self.viewModel.workouts[0], exercise: exercise)
                            self.viewModel.modelContext?.insert(ExerciseModel(name: text))
                            self.dismiss()
                        }
                    } label: {
                        CustomButton(title: "Create Exercise")
                    }
                } else {
                    List {
                        ForEach(self.filterExercises(exercises: self.exercises, filter: self.text)) { e in
                            Text(e.name)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                .onTapGesture {
                                    self.viewModel.addExercise(for: self.viewModel.workouts[0], exercise: ExerciseModel(name: e.name))
                                    self.dismiss()
                                }
                        }
                    }
                    .padding(-16)
                    .scrollContentBackground(.hidden)
                }
                
                Spacer()
            }
        }
    }

    func filterExercises(exercises: [ExerciseModel], filter: String) -> [ExerciseModel] {
        if(filter.isEmpty) {
            return exercises
        }
        
        return exercises.filter {
            $0.name.contains(filter)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: WorkoutModel.self, inMemory: true)
}
