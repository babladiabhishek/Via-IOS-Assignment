//
//  DataViewModelTests.swift
//  ViaplayAssignmentFTests
//
//  Created by Abhishek Babladi on 2023-03-01.
//

import XCTest
@testable import ViaplayAssignmentF
import CoreData

final class DataViewModelTests: XCTestCase {

    var viewModel: DataViewModel!
    var mockService: MockService!
    var mockDelegate: MockResultManagerDelegate!
    let dummyUrl = URL(string: "https://content.viaplay.com/ios-se")!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockService = MockService()
        viewModel = DataViewModel()
        mockDelegate = MockResultManagerDelegate()

        //
    }

    override func tearDownWithError() throws {
        mockService = nil
        viewModel = nil
        mockDelegate = nil
        try super.tearDownWithError()
    }

    func testGetData_Success() async throws {
        // Given
        viewModel.delegate = mockDelegate
        // When
        await viewModel.getData()

        // Then
        XCTAssertTrue(mockDelegate.didUpdateWithResultCalled)
        XCTAssertFalse(mockDelegate.didFailWithErrorCalled)
        XCTAssertNotNil(viewModel.dataResult)
    }

    func testViaplaySectionOneData() async throws {
      let viewModel = try await DataInfoViewModel(dataInfo: mockService.performRequest(url: dummyUrl)!)
      XCTAssertEqual(viewModel.dataInfo.links.viaplaySections[0].id, "35bb8a90-d40e-11e2-8b8b-0800200c9a66")
        XCTAssertEqual(viewModel.dataInfo.links.viaplaySections.first?.title, "Serier")
      XCTAssertEqual(viewModel.dataInfo.links.viaplaySections[0].href,
                     "https://content.viaplay.com/ios-se/serier{?dtg,productsPerPage}")
      XCTAssertEqual(viewModel.dataInfo.links.viaplaySections[0].type, "vod")
      XCTAssertEqual(viewModel.dataInfo.links.viaplaySections[0].name, "series")
      XCTAssertEqual(viewModel.dataInfo.links.viaplaySections[0].templated, true)
    }

    func test_DataInfoViewModel_dataCount() async throws {
      let viewModel = try await DataInfoViewModel(dataInfo: mockService.performRequest(url: dummyUrl)!)
      XCTAssertEqual(viewModel.dataInfo.links.viaplaySections.count, 4)
    }
}
