//
//  ExerciseCard.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-02-16.
//

import SwiftUI

struct ExerciseCard: View {
    var title: String
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    NavigationLink(destination: HistoryPage2()) {
                        Image(systemName: "pencil")
                            .foregroundColor(.primary70)
                            .padding(8)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                    }
                }
                
                    .frame(width: 300, height: 80)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                }
            }
        }
    }

#Preview {
    ExerciseCard(title: "Exercise Title")
}
