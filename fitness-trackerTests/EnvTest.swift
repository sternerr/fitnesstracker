//
//  Test.swift
//  fitness-trackerTests
//
//  Created by Noah Sterner on 2025-03-04.
//

import Testing
@testable import fitness_tracker

struct EnvTest {
    
    private var env: EnvConfig = EnvConfig()
    
    @Test func plistTest() async throws {
        #expect(env.API_KEY.isEmpty == false    , "API_KEY should not be empty")
    }

}
