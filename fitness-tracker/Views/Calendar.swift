//
//  Calendar.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-02-16.
//

import SwiftUI

struct Calendar: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            DatePicker("Välj ett datum", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .padding()
        }
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    Calendar()
}
