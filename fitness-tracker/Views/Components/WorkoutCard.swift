//
//  WorkoutCard.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-03.
//

import SwiftUI
import SwiftData

struct WorkoutCard: View {
    @State var viewModel: WorkoutViewModel
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(self.viewModel.workout!.name)
                    Spacer()
                    NavigationLink {
                        EditWorkoutPage(viewModel: self.$viewModel)
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
                        Text("\(self.viewModel.getVolume())")
                    }
                    
                    Spacer()
                    VStack{
                        Text("Reps")
                        Text("\(self.viewModel.getRepsCount())")
                    }
                    Spacer()
                    VStack{
                        Text("Sets")
                        Text("\(self.viewModel.getSetsCount())")
                    }
                    Spacer()
                    VStack{
                        Text("Exercises")
                        Text("\(self.viewModel.getExerciseCount())")
                    }
                }
            }
            .padding()
        }
        .background(.secondarySurfaceContainer)
        .clipShape(.rect(cornerRadius: 10))
    }
}
