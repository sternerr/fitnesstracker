//
//  APIService.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-02-13.
//

import Foundation

struct Exercise: Decodable, Identifiable {
    let id = UUID()
    
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
    
    func fetchExercises() async {
        let url = URL(string: "\(baseURL)/exercises")
        var request = URLRequest(url: url!)
        request.setValue(ENV.API_KEY, forHTTPHeaderField: "x-api-key")
            
        if let (data, response) = try? await URLSession.shared.data(for: request) {
            print(String(decoding: data, as: UTF8.self))
            print(response)
        }
    }
        
    func exerciesFromFile<T: Decodable>() -> T{
        guard let file = Bundle.main.url(forResource: "data", withExtension: "json")
        else { fatalError("File not found") }
        
        do {
            let data = try Data(contentsOf: file)
            return JSONfrom(data: data)
        } catch {
            fatalError("")
        }
    }
    
    private func JSONfrom<T: Decodable>(data: Data) -> T {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("")
        }
    }
}
