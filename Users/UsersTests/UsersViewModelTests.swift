//
//  UsersViewModelTests.swift
//  UsersTests
//
//  Created by Argh on 10/9/24.
//

import XCTest
@testable import Users

final class UsersViewModelTests: XCTestCase {
    
    private var sut: UsersViewModel!
    private var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        sut = UsersViewModel(apiService: mockAPIService)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_getUsers_success() {
        // Arrange
        let expectation = self.expectation(description: "Fetch users from API")
        mockAPIService.shouldReturnError = false
        
        sut.getUsers()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if self.sut.users.count > 0 {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2) { error in
            XCTAssertEqual(self.sut.users.count, 1)
            XCTAssertEqual(self.sut.users.first?.name, "John Doe")
        }
        
        
    }
    
    func testGetUsersFailure() {
        mockAPIService.shouldReturnError = true
        let expectation = self.expectation(description: "Fetch users from API")
        
        sut.getUsers()
        
        DispatchQueue.main.async {
            if self.sut.users.isEmpty {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2) { error in
            XCTAssertEqual(self.sut.users.count, 0)
        }
    }
    
}
