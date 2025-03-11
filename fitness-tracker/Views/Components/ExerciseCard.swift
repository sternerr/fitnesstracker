//
//  ExerciseCard.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-02.
//

import SwiftUI
import SwiftData

struct ExerciseCard: View {
    @Binding var viewModel: WorkoutViewModel
    @State var exerciseViewModel: ExerciseViewModel
    
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
                self.viewModel.remove(evm: exerciseViewModel)
                self.viewModel.remove(exerciseViewModel: exerciseViewModel)
            }
            
//            if(self.exercise.sets.count > 0) {
//                VStack {
//                    ForEach(self.exercise.sets) { set in
//                        SwipeToDelete {
//                            SetView(set: set, index: self.exercise.sets.firstIndex(where: { $0 == set }) ?? 0)
//                        } action: {
//                            self.viewModel.removeSet(for: exercise, set: set)
//                        }
//                    }
//                }
//                .padding(.bottom, 8)
//            }
        }
        .background(.secondarySurfaceContainer)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: WorkoutModel.self, inMemory: true)
}
