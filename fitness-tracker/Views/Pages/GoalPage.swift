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
    
    @State private var viewModel = GoalViewModel()
    @State private var selectedGoal: GoalModel? = nil
    
    var body: some View {
        NavigationStack {
            Container {
                Block {
                    TopBar(text: "Goals") {
                        Spacer()
                    }
                }
                
                List {
                    ForEach(viewModel.goals) { item in
                        GoalRow(goal: item, selectedGoal: $selectedGoal)
                            .swipeActions {
                                Button(role: .destructive) {
                                    viewModel.removeGoal(goal: item)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                .tint(.delete)
                            }
                    }
                    
                }
                .padding(-8)
                .scrollContentBackground(.hidden)
                .navigationDestination(item: $selectedGoal) { _ in
                    SaveGoalPage(viewModel: viewModel, selectedGoal: $selectedGoal, mode: .edit)
                }
                NavigationLink(
                    destination: SaveGoalPage(viewModel: viewModel, selectedGoal: .constant(nil), mode: .add)
                        .navigationBarHidden(true)
                ){
                    CustomButton(title: "New Goal")
                }
                
                Spacer()
                
            }
            
            .onAppear{
                self.viewModel.modelContext = self.modelContext
                self.viewModel.fetchGoals()
            }
        }
    }
}

struct GoalRow: View {
    var goal: GoalModel
    @Binding var selectedGoal: GoalModel?
    
    var body: some View {
        HStack {
            Text(goal.title)
                .padding()
                .cornerRadius(8)

            Spacer()
            Button {
                selectedGoal = goal
            } label: {
                Image(systemName: "pencil")
                    .font(.system(size: 20))
                    .foregroundColor(.primary70)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
            }
        }
        .background(
            .secondarySurfaceContainer,
            in: RoundedRectangle(cornerRadius: 8)
        )
    }
}

#Preview {
    GoalPage()
}
