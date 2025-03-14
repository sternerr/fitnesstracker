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
                        .chartXAxisLabel("Day")
                        .chartYAxisLabel("Volume (kg)")
                    }
                    .padding(32)
                    .background(.secondarySurfaceContainer)
                    .clipShape(.rect(cornerRadius: 10))
                }
                Spacer().frame(height: 32)

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


