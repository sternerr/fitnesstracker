//
//  ExerciseCard.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-02.
//

import SwiftUI
import SwiftData

struct ExerciseCard: View {
    @State var exerciseViewModel: ExerciseViewModel
    @Binding var workoutViewModel: WorkoutViewModel
    
    var body: some View {
        VStack {
            SwipeToDelete {
                HStack {
                    Text(self.exerciseViewModel.exercise!.name)
                        .font(.system(size: 20))
                    Spacer()
                    Button {
                        self.exerciseViewModel.add(set: SetModel())
                    } label: {
                        Image(systemName: "plus.app.fill")
                            .font(.system(size: 32))
                    }
                    .buttonStyle(.plain)
                }
                .padding()
                .background(.secondarySurfaceContainer)
            } action: {
                self.workoutViewModel.remove(exerciseViewModel: self.exerciseViewModel)
            }
            
            if(self.exerciseViewModel.setViewModels.count > 0) {
                VStack {
                    ForEach(self.exerciseViewModel.setViewModels) { svm in
                        SwipeToDelete {
                            SetView(setViewModel: svm, index: self.exerciseViewModel.setViewModels.firstIndex(where: { $0.set == svm.set! }) ?? 0)
                        } action: {
                            self.exerciseViewModel.remove(setViewModel: svm)
                        }
                    }
                }
                .padding(.bottom, 8)
            }
        }
        .background(.secondarySurfaceContainer)
        .onAppear {
            self.exerciseViewModel.fetchSets()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: WorkoutModel.self, inMemory: true)
}
