//
//  LogHistory.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-02-13.
//

import SwiftUI
import SwiftData

struct HistoryPage: View {
    @State private var date = Date()
    @State private var workouts: [WorkoutModel] = []
    
    var body: some View {
        NavigationStack {
            Container {
                Block {
                    TopBar(text: "History") { Spacer() }
                }
                
                Block {
                    ScrollView {
                        DatePicker("Start Date", selection: $date, displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                        
                        ForEach(workouts) { workout in
                            WorkoutCard(workout: workout)
                        }
                        .padding(.vertical, 4)
                    }
                }
                
            }
            .task {
                if(workouts.count < 2) {
                    workouts.append(WorkoutModel(name: "Workout 1"))
                    workouts[0].exercises.append(ExerciseModel(name: "Pull Up"))
                    workouts[0].exercises.append(ExerciseModel(name: "Pull Up"))
                    workouts[0].exercises[0].sets.append(SetModel(reps: 12, weight: 30))

                    workouts.append(WorkoutModel(name: "Workout 2"))
                    workouts[1].exercises.append(ExerciseModel(name: "Push Up"))
                    workouts[1].exercises[0].sets.append(SetModel(reps: 12, weight: 30))
                    workouts[1].exercises[0].sets.append(SetModel(reps: 12, weight: 30))
                }
                print(date)
            }
        }
    }
}

struct WorkoutCard: View {
    @State var workout: WorkoutModel
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(workout.name)
                    Spacer()
                    NavigationLink {
                        EditWorkoutPage(workout: workout)
                            .navigationBarHidden(true)
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 32))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .background(.secondarySurfaceContainer)
        .clipShape(.rect(cornerRadius: 10))
    }
}

struct EditWorkoutPage: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var workout: WorkoutModel
    
    var body: some View {
        Container  {
            
            Block {
                TopBar(text: "History") {
                    Image(systemName: "arrow.backward.square.fill")
                        .resizable()
                        .frame(width: 40.0, height: 40.0)
                        .foregroundStyle(.secondarySurfaceContainer)
                        .onTapGesture { dismiss() }
                    
                    Spacer()
                }
            }
            
            Block {
                ScrollView {
                    ForEach(workout.exercises, id: \.self) { exercise in
                        SwipeToDelete(action: {
                            print("Delete Exercise")
                        }) {
                            ExerciseCard(exercise: exercise)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HistoryPage()
}
