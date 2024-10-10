//
//  PostsViewModelTests.swift
//  UsersTests
//
//  Created by Argh on 10/9/24.
//

import XCTest
@testable import Users

final class PostsViewModelTests: XCTestCase {
    
    private var sut: PostsViewModel!
    private var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
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
        sut = PostsViewModel(apiService: mockAPIService, userModel: userModel)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_getPosts_success() {
        mockAPIService.shouldReturnError = false
        
        let expectation = self.expectation(description: "Fetch posts from API")
        
        sut.getPosts()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.sut.posts.count, 1)
            XCTAssertEqual(self.sut.posts.first?.title, "Title")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func test_getPosts_failure() {
        mockAPIService.shouldReturnError = true
        
        let expectation = self.expectation(description: "Fetch posts from API")
        
        sut.getPosts()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.sut.posts.isEmpty)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
