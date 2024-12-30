//
//  SampleMobileTest.swift
//  PeopleWork-iOS-Tests
//
//  Created by Michael Hedgpeth on 12/29/24.
//

import Testing

struct SampleMobileTest {
    @Test func add() async throws {
        #expect(1 + 1 == 2)
    }
}
