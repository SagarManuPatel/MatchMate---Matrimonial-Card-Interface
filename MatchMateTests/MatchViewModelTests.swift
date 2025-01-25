//
//  MatchViewModelTests.swift
//  MatchMate
//
//  Created by Sagar Patel on 25/01/25.
//
import XCTest
@testable import MatchMate

final class MatchViewModelTests: XCTestCase {
    var viewModel: MatchViewModel!
    var coreDataManager: CoreDataManager!

    override func setUpWithError() throws {
        coreDataManager = CoreDataManager.shared
        viewModel = MatchViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        coreDataManager = nil
    }

    func testFetchCachedProfiles() {
        viewModel.fetchCachedProfiles()
        XCTAssertEqual(viewModel.users.count, coreDataManager.fetchProfiles().count)
    }

    func testAcceptUser() {
        let id = "2144ab1b-TestID"
        let firstName = "Sagar"
        let lastName = "Patel"
        let imageURL = "https://example.com/image.jpg"
        let status = UserStatus.pending.rawValue
        let city = "Mumbai"
        let state = "Maharastra"
        let country = "India"
        
        coreDataManager.addUser(id: id, firstName: firstName, lastName: lastName, imageURL: imageURL, status: status, city: city, state: state, country: country)

        guard let user = coreDataManager.fetchProfiles().first(where: { $0.userId == id }) else {
            XCTFail("User not found")
            return
        }

        viewModel.accept(user: user)
        XCTAssertEqual(user.status, "Accepted")
    }

    func testDeclineUser() {
        let id = "2144ab1b-TestID"
        let firstName = "Sagar"
        let lastName = "Patel"
        let imageURL = "https://example.com/image.jpg"
        let status = UserStatus.pending.rawValue
        let city = "Mumbai"
        let state = "Maharastra"
        let country = "India"
        
        coreDataManager.addUser(id: id, firstName: firstName, lastName: lastName, imageURL: imageURL, status: status, city: city, state: state, country: country)

        guard let user = coreDataManager.fetchProfiles().first(where: { $0.userId == id }) else {
            XCTFail("User not found")
            return
        }

        viewModel.decline(user: user)
        XCTAssertEqual(user.status, UserStatus.declined.rawValue)
    }
}
