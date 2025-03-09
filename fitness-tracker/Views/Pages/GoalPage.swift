//
//  GoalPage.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-02-13.
//


import SwiftUI

struct GoalPage: View {
    @State private var goals: [Goal] = []
    @State private var selectedGoal: Goal? = nil
    
    var body: some View {
        NavigationStack {
            Container {
                Block {
                    TopBar(text: "Goals") {
                        Spacer()
                    }
                }
                
                List {
                    ForEach($goals) { $item in
                        GoalRow(goal: $item, selectedGoal: $selectedGoal)
                            .swipeActions {
                                Button(role: .destructive) {
                                    //goals.remove(at: index)
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
                    SaveGoalPage(goals: $goals, selectedGoal: $selectedGoal)
                }
                NavigationLink(
                    destination: SaveGoalPage(goals: $goals, selectedGoal: .constant(nil))
                        .navigationBarHidden(true)
                ){
                    CustomButton(title: "New Goal")
                }
                
                Spacer()
                
            }
        }
    }
}

struct GoalRow: View {
    @Binding var goal: Goal
    @Binding var selectedGoal: Goal?
    
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
