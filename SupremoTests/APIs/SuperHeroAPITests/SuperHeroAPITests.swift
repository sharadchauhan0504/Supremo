//
//  SuperHeroAPITests.swift
//  SupremoTests
//
//  Created by Sharad on 15/11/20.
//

import XCTest
@testable import Supremo

class SuperHeroAPITests: XCTestCase {

    var session: MockURLSession!
    
    override func setUpWithError() throws {
        session = MockURLSession()
    }

    override func tearDownWithError() throws {
        session = nil
    }

    /// Unit test case for searching superheroes
    ///
    /// - Parameter param: query
    /// - Returns: Returns array of results
    /// - Throws:
    func testGETSearchedSuperHeroesAPI() {
        let asyncExpectation     = expectation(description: "Async block executed")
        session.testDataJSONFile = "SearchMoviesOutput"
        let api                  = SuperHeroAPIService.search("spider")
        let router               = APIRouter<SuperHeroSearchOutput>(session: session)
        router.requestData(api) { [weak self] (output, statusCode, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(output)
            XCTAssert(statusCode == 200, "HTTP Error code")
            XCTAssert(self?.session.testMethod == "GET", "Method should be GET")
            asyncExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
