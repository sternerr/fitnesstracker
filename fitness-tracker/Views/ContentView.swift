//
//  ContentView.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-02-06.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var modelContext
   
    @State var viewModel = WorkoutViewModel()
    
    @State var selectedTab: Int = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            Dashboard()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Dashboard")
                }
                .tag(0)
            
            HistoryPage()
                .tabItem{
                    Image(systemName: "calendar")
                    Text("History")
                }
                .tag(1)

            AddWorkoutPage(selectedTab: $selectedTab)
                .tabItem{
                    Image(systemName: "plus.circle")
                    Text("Add Workout")
                }
                .tag(2)
            
            GoalPage()
                .tabItem {
                    Image(systemName: "flag.circle.fill")
                    Text("Goals")
                }
                .tag(3)
        }
        .tint(colorScheme == .light ? .Primary : .primary70)
        .onAppear(perform: {
            UITabBar.appearance().unselectedItemTintColor = colorScheme == .light ? .primary15 : .primary90
            
            UITabBar.appearance().backgroundColor = .surfaceContainer.withAlphaComponent(1)
        })
//        .task {
//            if(self.exercises.count <= 0) {
//                let res = await APIService.shared.fetchExercises()
//                
//                res.forEach {
//                    self.modelContext.insert(ExerciseModel(name: $0.name))
//                }
//            }
//        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: WorkoutModel.self, inMemory: true)
}
