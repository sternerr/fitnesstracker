//
//  GoalPage.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-02-13.
//


import SwiftUI
import SwiftData

struct GoalPage: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var viewModel = GoalPageViewModel()
    @State private var selectedGoalViewModel: GoalViewModel? = nil
    
    var body: some View {
        NavigationStack {
            Container {
                Block {
                    TopBar(text: "Goals") {
                        Spacer()
                    }
                }
            
                ScrollView {
                    ForEach(self.viewModel.goalViewModels) { gvm in
                        SwipeToDelete {
                            GoalRow(viewModel: self.$viewModel, goalViewModel: gvm)
                        } action: {
                            self.viewModel.removeGoal(goalViewModel: gvm)
                        }
                    }
                    
                    NavigationLink(
                        destination: SaveGoalPage(viewModel: self.$viewModel, goalViewModel: self.$selectedGoalViewModel)
                            .navigationBarHidden(true)
                    ){
                        CustomButton(title: "New Goal")
                    }
                }
                .padding()
                
            }
        }
        .onAppear{
            self.viewModel.modelContext = self.modelContext
            self.viewModel.fetchGoals()
            self.viewModel.fetchExercises()
        }
    }
}

struct GoalRow: View {
    @Binding var viewModel: GoalPageViewModel
    @State var goalViewModel: GoalViewModel?
    
    @State private var progress: Double = 0
    
    var body: some View {
        VStack {
            HStack {
                Text(self.goalViewModel!.goal.title)
                
                Spacer()
                
                NavigationLink {
                    SaveGoalPage(viewModel: self.$viewModel, goalViewModel: self.$goalViewModel)
                        .navigationBarHidden(true)
                } label: {
                    Image(systemName: "pencil.circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(.primary70)
                }
            }
            
            ProgressView(value: progress)
                .progressViewStyle(.linear)
        }
        .padding()
        .background(.secondarySurfaceContainer)
        .onAppear {
            self.progress = self.viewModel.weightProgress(gvm: self.goalViewModel!)
            print(self.progress)
        }
    }
}

#Preview {
    GoalPage()
}
