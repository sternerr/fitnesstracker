//
//  LogSession.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-02-13.
//

import SwiftUI

struct LogSessionPage: View {
    @State private var exercises: [String] = []
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    print ("Back pressed")
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.primary70)
                }
                
                Spacer()
                
                Text("Add Exercise")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    print("Done pressed")
                }) {
                    Text("Done")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.primary70)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            
            List {
                ForEach(exercises, id:\.self) {exercise in
                    ExerciseRow(exerciseName: exercise)
                        .swipeActions {
                            Button(role: .destructive) {
                                if let index = exercises.firstIndex(of: exercise) {
                                    exercises.remove(at: index)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
                .onDelete(perform: deleteExercise)
            }
            
            Button(action: {
                exercises.append("New Exercise \(exercises.count + 1)")
            }) {
                Text ("Add Exercise")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.primary70)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding(.horizontal)
    }
    
    func deleteExercise(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
    }
}

struct ExerciseRow: View {
    let exerciseName: String
    
    var body: some View {
        HStack {
            Text(exerciseName)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}
    
    #Preview {
        LogSessionPage()
    }
