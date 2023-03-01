//
//  MockService.swift
//  ViaplayAssignmentF
//
//  Created by Abhishek Babladi on 2022-11-07.
//

import Foundation
class MockService: DataViewModel {
  private let jsonString = """
{
    "_links": {
        "viaplay:sections": [
            {
                "id": "35bb8a90-d40e-11e2-8b8b-0800200c9a66",
                "title": "Serier",
                "href": "https://content.viaplay.com/ios-se/serier{?dtg,productsPerPage}",
                "type": "vod",
                "name": "series",
                "templated": true
            },
            {
                "id": "2037b330-d411-11e2-8b8b-0800200c9a66",
                "title": "Filmer",
                "href": "https://content.viaplay.com/ios-se/film{?dtg,productsPerPage}",
                "type": "vod",
                "name": "movie",
                "templated": true
            },
            {
                "id": "8e5febf0-d4e0-11e2-8b8b-0800200c9a66",
                "title": "Sport",
                "href": "https://content.viaplay.com/ios-se/sport{?dtg,productsPerPage}",
                "type": "vod",
                "name": "sport",
                "templated": true
            },
            {
                "id": "1a6a2ec0-d4e2-11e2-8b8b-0800200c9a66",
                "title": "Barn",
                "href": "https://content.viaplay.com/ios-se/barn{?dtg,productsPerPage}",
                "type": "vod",
                "name": "kids",
                "templated": true
            }
        ]
    }
}
"""
  
  func performRequest(url: URL) async throws -> DataResult? {
    let jsonData = jsonString.data(using: .utf8)!
    return try JSONDecoder().decode(DataResult.self, from: jsonData)
  }
  
}
