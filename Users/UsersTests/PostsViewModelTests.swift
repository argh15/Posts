//
//  PostsViewModelTests.swift
//  UsersTests
//
//  Created by Argh on 10/9/24.
//

import XCTest
@testable import Users

/// Unit tests for the `PostsViewModel` class.
final class PostsViewModelTests: XCTestCase {
    
    /// The system under test (SUT), which is an instance of `PostsViewModel`.
    private var sut: PostsViewModel!
    
    /// A mock implementation of `APIServiceProtocol` used for testing.
    private var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        
        // Create a mock user model to be used in the view model.
        let userModel = UserModel(
            id: 1,
            name: "John Doe",
            username: "johndoe",
            email: "johndoe@example.com",
            address: Address(
                street: "123 Main St",
                suite: "A",
                city: "Somewhere",
                zipCode: "12345"),
            phone: "555-555-5555",
            website: "example.com",
            company: Company(
                name: "Company",
                catchPhrase: "Catchphrase")
        )
        
        // Initialize the system under test with the mock API service and user model.
        sut = PostsViewModel(apiService: mockAPIService, userModel: userModel)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    /// Tests the successful retrieval of posts from the mock API service.
    func test_getPosts_success() {
        // Arrange
        mockAPIService.shouldReturnError = false
        let expectation = self.expectation(description: "Fetch posts from API")
        
        // Act
        sut.getPosts()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Assert
            XCTAssertEqual(self.sut.posts.count, 1) // Verify that one post is retrieved
            XCTAssertEqual(self.sut.posts.first?.title, "Title") // Verify the post's title
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    /// Tests the behavior of the view model when post retrieval fails.
    func test_getPosts_failure() {
        // Arrange
        mockAPIService.shouldReturnError = true
        let expectation = self.expectation(description: "Fetch posts from API")
        
        // Act
        sut.getPosts()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Assert
            XCTAssertTrue(self.sut.posts.isEmpty) // Verify that no posts are retrieved
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
