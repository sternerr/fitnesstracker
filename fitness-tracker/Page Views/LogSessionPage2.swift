//
//  LogSessionWrite.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-02-16.
//

import SwiftUI

struct LogSessionWrite: View {
    @State private var exercises: [String] = []
    @State private var text: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Text("Add Exercise")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            TextEditor(text: $text)
                .frame(height:120)
                .border(Color.orange, width: 2)
                .padding(.top, 20)
            
            Button(action: {
                if !text.isEmpty {
                    exercises.append(text)
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
            
        }
    }
}

#Preview {
    LogSessionWrite()
}
