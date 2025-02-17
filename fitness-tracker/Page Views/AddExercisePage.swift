//
//  LogSessionWrite.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-02-16.
//

import SwiftUI

struct AddExercisePage: View {
    @Binding var exercises: [Exercise]
    @State private var text: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
            }
            
            TextField(text: $text) {}
                .frame(height:70)
                .border(Color.orange, width: 1)
                .padding(.top, 50)
            
            Button(action: {
                if !text.isEmpty {
                    exercises.append(Exercise(name: text))
                    text = ""
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.primary70)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top,30)
            Spacer()

        }
    }
}

#Preview {
    AddExercisePage()
}
