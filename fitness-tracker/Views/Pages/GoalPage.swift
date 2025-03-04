//
//  GoalPage.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-02-13.
//


import SwiftUI

struct GoalPage: View {
    @State private var goals: [Goal] = []
    @State private var didUpdateGoals: Bool = false
    
    var body: some View {
        NavigationStack {
            Container {
                Block {
                    TopBar(text: "Goals") {
                        Spacer()
                    }
                }
                
                List {
                    ForEach(goals.indices, id:\.self) { index in
                        GoalRow(goals: goals[index], didUpdate: $didUpdateGoals)
                            .swipeActions {
                                Button(role: .destructive) {
                                    goals.remove(at: index)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                .tint(.delete)
                            }
                    }
                    
                }
                .padding(-8)
                .scrollContentBackground(.hidden)
                .onChange(of: didUpdateGoals) {
                    
                }
                .navigationDestination(isPresented: $didUpdateGoals) {
                    SaveGoalPage(goals: $goals)
                }
                NavigationLink(
                    destination: SaveGoalPage(goals: $goals)
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
    @State var goals: Goal
    @Binding var didUpdate: Bool
    
    var body: some View {
        HStack {
            Text(goals.title)
                .padding()
                .cornerRadius(8)
            
            Spacer()
            Button {
                didUpdate = true
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

