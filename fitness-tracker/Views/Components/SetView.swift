//
//  SetView.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-02.
//

import SwiftUI
import SwiftData

struct SetView: View {
    @State var setViewModel: SetViewModel
    @State var index: Int
    
    @State private var repsText: Int = 0
    @State private var weightText: Int = 0
    
    var body: some View {
        HStack {
            Text("\(index + 1)")
            Spacer()
            InputField(type: .Reps, text: $repsText)
            Spacer()
            InputField(type: .Weight, text: $weightText)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 32)
        .background(.secondarySurfaceContainer)
    }
    
    enum InputType {
        case Reps
        case Weight
    }
    
    @ViewBuilder
    func InputField(type: InputType, text: Binding<Int>) -> some View {
        HStack {
            TextField("0", value: text, formatter: NumberFormatter())
                .multilineTextAlignment(.trailing)
                .keyboardType(.numberPad)
                .onChange(of: text.wrappedValue, initial: false) { oldState, newState in
                    
                    if(type == .Weight) {
                        self.setViewModel.set?.reps = Int(newState)
                    } else if(type == .Reps) {
                        self.setViewModel.set?.weight = Int(newState)
                    }
                }
                
            if(type == .Weight) {
                Text("kg")
            } else {
                Text("reps")
            }
        }
    }
}
