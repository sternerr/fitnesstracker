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
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    print ("Back pressed")
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.primary70)
                }
                
                Spacer()
                
                Text("Add Exercise")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    print("Done pressed")
                }) {
                    Text("Done")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.primary70)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            
            TextEditor(text: $text)
                .frame(height:120)
                .border(Color.orange, width: 2)
                .padding(.top, 20)
            
            Button(action: {
                if !text.isEmpty {
                    exercises.append(text)
                    text = ""
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
