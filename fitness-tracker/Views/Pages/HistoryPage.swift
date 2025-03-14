//
//  LogHistory.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-02-13.
//

import SwiftUI
import SwiftData

struct HistoryPage: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: ViewModel = ViewModel()
    
    @State private var date = Date()
    
    var body: some View {
        NavigationStack {
            Container {
                Block {
                    TopBar(text: "History") { Spacer() }
                }
                
                Block {
                    ScrollView {
                        DatePicker("Start Date", selection: $date, displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                            .onChange(of: date, initial: true) {
                                self.viewModel.fetch(byDate: DateToString(date: self.date).result)
                            }
                        
                        ForEach(self.viewModel.workoutViewModels) { wvm in
                            SwipeToDelete {
                                WorkoutCard(viewModel: wvm)
                            } action: {
                                self.viewModel.removeWorkout(workoutViewModel: wvm)
                            }
                        }
                    }
                }
                
            }
        }
        .onAppear {
            self.viewModel.modelContext = self.modelContext
            self.viewModel.fetch(byDate: date.formatted(date: .numeric, time: .omitted))
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: WorkoutModel.self, inMemory: true)
}
