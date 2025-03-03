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
    
    @State var selectedTab: Int = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            HistoryPage()
            .tabItem{
                Image(systemName: "clock")
                Text("History")
            }
            .tag(0)

            AddWorkoutPage(selectedTab: $selectedTab)
            .tabItem{
                Image(systemName: "plus.circle")
                Text("Add Workout")
            }
            .tag(1)
        }
        .tint(colorScheme == .light ? .Primary : .primary70)
        .onAppear(perform: {
            UITabBar.appearance().unselectedItemTintColor = colorScheme == .light ? .primary15 : .primary90
            
            UITabBar.appearance().backgroundColor = .surfaceContainer.withAlphaComponent(1)
        })
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
