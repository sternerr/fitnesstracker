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
                Spacer()
                Text("Add Exercise")
                    .font(.system(size: 16))
                    .padding(.top, 10)
                Spacer()
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
            
            NavigationStack {
                NavigationLink(destination: LogSessionPage2()) {
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
                .cornerRadius(8)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}
    
    #Preview {
        LogSessionPage()
    }
