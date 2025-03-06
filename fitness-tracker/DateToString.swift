//
//  DateToString.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-05.
//

import Foundation

class DateToString {
    var result: String = ""
    
    init(date: Date) {
        self.result = self.formatt(date: date)
    }
    
    private func formatt(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}
