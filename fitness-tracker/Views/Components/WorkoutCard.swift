//
//  WorkoutCard.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-03.
//

import SwiftUI
import SwiftData

struct WorkoutCard: View {
    @Binding var viewModel: WorkoutViewModel
    @State var workout: WorkoutModel
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(workout.name)
                    Spacer()
                    NavigationLink {
                        EditWorkoutPage(viewModel: self.$viewModel, workout: workout)
                            .navigationBarHidden(true)
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 32))
                    }
                    .buttonStyle(.plain)
                }
                HStack {
                    VStack{
                        Text("Volume")
                        Text("\(self.viewModel.getVolume(for: self.workout))")
                    }
                    
                    Spacer()
                    VStack{
                        Text("Reps")
                        Text("\(self.viewModel.getRepsCount(for: self.workout))")
                    }
                    Spacer()
                    VStack{
                        Text("Sets")
                        Text("\(self.viewModel.getSetsCount(for: self.workout))")
                    }
                    Spacer()
                    VStack{
                        Text("Exercises")
                        Text("\(self.viewModel.getExerciseCount(for: self.workout))")
                    }
                }
            }
            .padding()
        }
        .background(.secondarySurfaceContainer)
        .clipShape(.rect(cornerRadius: 10))
    }
}
