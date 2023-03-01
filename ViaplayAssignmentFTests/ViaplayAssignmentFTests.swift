//
//  ViaplayAssignmentFTests.swift
//  ViaplayAssignmentFTests
//
//  Created by Abhishek Babladi on 2022-11-06.
//

import XCTest
@testable import ViaplayAssignmentF

final class ViaplayAssignmentFTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testExample() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    // Any test you write for XCTest can be annotated as throws and async.
    // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
    // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
  }

  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }

  func testViaplaySectionOneData() async throws {
    let mock = MockService()
    let dummyUrl = URL(string: "https://content.viaplay.com/ios-se")!
    let viewModel = try await DataInfoViewModel(dataInfo: mock.performRequest(url: dummyUrl)!)
    XCTAssertEqual(viewModel.dataInfo.links.viaplaySections[0].id, "35bb8a90-d40e-11e2-8b8b-0800200c9a66")
      XCTAssertEqual(viewModel.dataInfo.links.viaplaySections.first?.title, "Serier")
    XCTAssertEqual(viewModel.dataInfo.links.viaplaySections[0].href,
                   "https://content.viaplay.com/ios-se/serier{?dtg,productsPerPage}")
    XCTAssertEqual(viewModel.dataInfo.links.viaplaySections[0].type, "vod")
    XCTAssertEqual(viewModel.dataInfo.links.viaplaySections[0].name, "series")
    XCTAssertEqual(viewModel.dataInfo.links.viaplaySections[0].templated, true)

  }

  func test_DataInfoViewModel_dataCount() async throws {
    let mock = MockService()
    let dummyUrl = URL(string: "https://content.viaplay.com/ios-se")!
    let viewModel = try await DataInfoViewModel(dataInfo: mock.performRequest(url: dummyUrl)!)
    XCTAssertEqual(viewModel.dataInfo.links.viaplaySections.count, 4)
  }

  override func setUp() {
    super.setUp()
  }

}
