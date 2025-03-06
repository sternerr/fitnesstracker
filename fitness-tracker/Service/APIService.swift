//
//  APIService.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-02-13.
//

import SwiftData
import Foundation

struct Exercise: Decodable {
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

//Singleton Pattern
class APIService {
    static let shared = APIService()
    private let baseURL = URL(string: "https://api.api-ninjas.com/v1")!
    
    private init() {}
    
    func fetchExercises() async -> [Exercise] {
        let url = URL(string: "\(baseURL)/exercises")
        var request = URLRequest(url: url!)
        request.setValue(ENV.API_KEY, forHTTPHeaderField: "x-api-key")
            
        if let (data, _) = try? await URLSession.shared.data(for: request) {
            return self.JSONfrom(data: data)
        }
        
        return []
    }
    
    private func JSONfrom(data: Data) -> [Exercise] {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Exercise].self, from: data)
        } catch {
            fatalError("")
        }
    }
}

struct Goal: Identifiable, Hashable {
    let id: UUID = UUID()
    var title: String
    var description: String
}
