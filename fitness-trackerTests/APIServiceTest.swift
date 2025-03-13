//
//  Test.swift
//  fitness-trackerTests
//
//  Created by Noah Sterner on 2025-03-05.
//

import Testing
@testable import fitness_tracker

struct APIServiceTest {
    
    @Test func filter_EmptyFilter_Test() async throws {
        let suggestions = Suggestions(suggestions: [
            Suggestions.Suggestion(value: "Pull Ups"),
            Suggestions.Suggestion(value: "Push Ups"),
            Suggestions.Suggestion(value: "Pullover")
        ])
        
        let res = APIService.shared.filter(suggestions: suggestions.suggestions, filter: "")
        
        #expect(suggestions.suggestions == res, "Filter doesn't return all elements")
    }
    
    @Test func filter_MatchingFilter_Test() async throws {
        let suggestions = Suggestions(suggestions: [
            Suggestions.Suggestion(value: "Pull Ups"),
            Suggestions.Suggestion(value: "Push Ups"),
            Suggestions.Suggestion(value: "Pullover")
        ])
        
        let res = APIService.shared.filter(suggestions: suggestions.suggestions, filter: "Pullover")
        
        #expect(res.count == 1, "Filter should return 1 element")
        #expect(suggestions.suggestions.last == res.first, "Filter do not return right element")
    }
    
    @Test func filter_NoMatch_Test() async throws {
        let suggestions = Suggestions(suggestions: [
            Suggestions.Suggestion(value: "Pull Ups"),
            Suggestions.Suggestion(value: "Push Ups"),
            Suggestions.Suggestion(value: "Pullover")
        ])
        
        let res = APIService.shared.filter(suggestions: suggestions.suggestions, filter: "Pulloverr")
        #expect(res.isEmpty, "Filter do is not empty")
    }
}
