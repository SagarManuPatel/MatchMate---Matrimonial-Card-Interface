//
//  CoreDataTests.swift
//  MatchMate
//
//  Created by Sagar Patel on 25/01/25.
//

import XCTest
import CoreData
@testable import MatchMate

final class CoreDataTests: XCTestCase {
    var coreDataManager: CoreDataManager!
    var testContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        coreDataManager = CoreDataManager.shared
        testContext = coreDataManager.persistentContainer.newBackgroundContext()
    }

    override func tearDownWithError() throws {
        coreDataManager = nil
        testContext = nil
    }

    func testAddUser() throws {
        let id = "2144ab1b-fcd2-42d8-90d3-4b9de62df98c"
        let firstName = "Sagar"
        let lastName = "Patel"
        let imageURL = "https://example.com/image.jpg"
        let status = UserStatus.pending.rawValue
        let city = "Mumbai"
        let state = "Maharastra"
        let country = "India"

        coreDataManager.addUser(id: id, firstName: firstName, lastName: lastName, imageURL: imageURL, status: status, city: city, state: state, country: country)

        let users = coreDataManager.fetchProfiles()
        XCTAssertTrue(users.contains(where: { $0.userId == id }))
        
//        XCTAssertEqual(users.count, 1)
    }

    func testUpdateUserStatus() throws {
        let id = "2144ab1b-fcd2-42d8-90d3-4b9de62df98c"
        let firstName = "Sagar"
        let lastName = "Patel"
        let imageURL = "https://example.com/image.jpg"
        let status = UserStatus.pending.rawValue
        let city = "Mumbai"
        let state = "Maharastra"
        let country = "India"

        coreDataManager.addUser(id: id, firstName: firstName, lastName: lastName, imageURL: imageURL, status: status, city: city, state: state, country: country)
        coreDataManager.updateUserStatus(id: id, status: UserStatus.accepted.rawValue)

        let users = coreDataManager.fetchProfiles()
        XCTAssertTrue(users.contains(where: { $0.userId == id && $0.status == UserStatus.accepted.rawValue }))
    }
}
