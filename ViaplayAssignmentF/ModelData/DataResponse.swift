//
//  DataResponse.swift
//  ViaplayAssignment
//
//  Created by Abhishek Babladi on 2022-11-06.
//

import Foundation

struct DataResult: Codable {
  let links: Links
  enum CodingKeys: String, CodingKey {
    case links = "_links"
  }
}

struct Links: Codable {
  let viaplaySections: [ViaplaySection]
  enum CodingKeys: String, CodingKey {
    case viaplaySections = "viaplay:sections"
  }
}

struct ViaplaySection: Codable {
  let id, title, href, type: String
  let name: String
  let templated: Bool
}

