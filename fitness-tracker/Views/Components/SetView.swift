//
//  SetView.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-02.
//

import SwiftUI
import SwiftData

struct SetView: View {
    @State var set: SetModel
    @State var index: Int
    
    @State private var repsText: String = ""
    @State private var weightText: String = ""
    
    var body: some View {
        HStack {
            Text("\(index + 1)")
            Spacer()
            InputField(type: .Reps, text: $set.reps)
            Spacer()
            InputField(type: .Weight, text: $set.weight)
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
                
            if(type == .Weight) {
                Text("kg")
            } else {
                Text("reps")
            }
        }
    }
}
