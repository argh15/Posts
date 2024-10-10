//
//  UsersViewModelTests.swift
//  UsersTests
//
//  Created by Argh on 10/9/24.
//

import XCTest
@testable import Users

/// Unit tests for the `UsersViewModel` class.
final class UsersViewModelTests: XCTestCase {
    
    /// The system under test (SUT), which is an instance of `UsersViewModel`.
    private var sut: UsersViewModel!
    
    /// A mock implementation of `APIServiceProtocol` used for testing.
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
    
    /// Tests the successful retrieval of users from the mock API service.
    func test_getUsers_success() {
        // Arrange
        let expectation = self.expectation(description: "Fetch users from API")
        mockAPIService.shouldReturnError = false
        
        // Act
        sut.getUsers()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Assert
            if self.sut.users.count > 0 {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2) { error in
            XCTAssertEqual(self.sut.users.count, 1) // Verify that one user is retrieved
            XCTAssertEqual(self.sut.users.first?.name, "John Doe") // Verify the user's name
        }
    }
    
    /// Tests the behavior of the view model when user retrieval fails.
    func testGetUsersFailure() {
        // Arrange
        mockAPIService.shouldReturnError = true
        let expectation = self.expectation(description: "Fetch users from API")
        
        // Act
        sut.getUsers()
        
        DispatchQueue.main.async {
            // Assert
            if self.sut.users.isEmpty {
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2) { error in
            XCTAssertEqual(self.sut.users.count, 0) // Verify that no users are retrieved
        }
    }
}
