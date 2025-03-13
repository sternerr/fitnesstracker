//
//  Dashboard.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-02-13.
//

import SwiftUI
import SwiftData
import Charts

struct ChartData: Identifiable {
    let id = UUID()
    let date: Date
    let volume: Int
}

struct Dashboard: View {
    @Environment(\.modelContext) var modelContext
    @State var viewModel = ViewModel()
    @Binding var selectedTab: Int
    
    @Query(sort: \WorkoutModel.date, order: .reverse) private var workouts: [WorkoutModel]
    
   
//    private var chartData: [ChartData] {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//        
//        return workouts.compactMap { workout in
//            guard let date = dateFormatter.date(from: workout.date) else {
//                return ChartData(date: Date.now, volume: 0)
//            }
//            
//            var volume = 0
//            
//            for exercise in workout.exercises {
//                for set in exercise.sets {
//                    volume += set.weight * set.reps
//                }
//            }
//            
//            return ChartData(
//                date: date,
//                volume: volume
//            )
//        }
//        .sorted { $0.date < $1.date }
//    }
     
    var body: some View {
        NavigationStack {
            Container {
                Block {
                    TopBar(text: "Dashboard") {
                        Spacer()
                    }
                }
                
                Block {
                    HStack {
                        Text("Volume chart")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    VStack {
                        Chart {
                            ForEach(self.viewModel.workoutViewModels.prefix(7)) { wvm in
                                BarMark(
                                    x: .value("Date", wvm.workout!.date),
                                    y: .value("Volume", wvm.getVolume())
                                )
                            }
                        }
                        .frame(height: 300)
                        .chartXScale(
                            domain: .automatic(includesZero: false, reversed: true)
                        )
                    }
                    .padding(32)
                    .background(.secondarySurfaceContainer)
                    .clipShape(.rect(cornerRadius: 10))
                }
                Spacer().frame(height: 32)
                //            Chart {
                //                ForEach(chartData) { item in
                //                    LineMark(
                //                        x: .value("Date", item.date, unit: .day),
                //                        y: .value("Volume", item.volume)
                //                    )
                //                    .foregroundStyle(Color.primary70.gradient)
                //                    .cornerRadius(8)
                //                }
                //            }
                //            .chartXAxis {
                //                AxisMarks(values: .stride(by: .day)) { _ in
                //                    AxisValueLabel(format: .dateTime.day().month())
                //                }
                //            }
                //            .chartYAxis {
                //                AxisMarks { value in
                //                    AxisValueLabel()
                //                    AxisGridLine()
                //                }
                //            }
                //            .frame(height: 200)
                //            .padding()
                
                Block {
                    HStack {
                        Text("Goals")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            self.selectedTab = 3
                        } label: {
                            Text("Show more")
                        }
                    }
                    ForEach(self.viewModel.goalViewModels.prefix(3)) {
                        GoalCard(goalViewModel: $0)
                    }
                }
                
                Spacer()
            }
        }
        .onAppear {
            self.viewModel.modelContext = modelContext
            self.viewModel.fetchGoals()
            self.viewModel.fetchExercises()
            self.viewModel.fetchWorkout()
        }
    }
    
    @ViewBuilder
    func GoalCard(goalViewModel: GoalViewModel) -> some View {
        VStack {
            HStack {
                Text(goalViewModel.goal.title)
                
                Spacer()
            }
            
            ProgressView(value: self.viewModel.weightProgress(gvm: goalViewModel))
                .progressViewStyle(.linear)
        }
        .padding()
        .background(.secondarySurfaceContainer)
        .clipShape(.rect(cornerRadius: 10))
    }
}


