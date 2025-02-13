//
//  ContentView.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-02-06.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        
        TabView {
            NavigationStack{
                Dashboard()
            }
            .tabItem{
                Image(systemName: "house.fill")
                Text("Dashboard")
            }
            
            NavigationStack{
                LogSessionPage()
            }
            .tabItem{
                Image(systemName: "plus.circle")
                Text("Add Exercise")
            }
            
            NavigationStack{
                GoalPage()
            }
            .tabItem{
                Image(systemName: "flag.fill")
                Text("Goals")
            }
            
            NavigationStack{
                HistoryPage()
            }
            .tabItem{
                Image(systemName: "clock")
                Text("History")
            }
        }
    }
}
#Preview {
    ContentView()
        
}
