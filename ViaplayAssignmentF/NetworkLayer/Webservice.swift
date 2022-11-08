//
//  Webservice.swift
//  ViaplayAssignment
//
//  Created by Abhishek Babladi on 2022-11-06.
//

import Foundation

struct Webservice {
  func performRequest(url: URL) async throws -> DataResult? {
    let (data,_) =  try await URLSession.shared.data(from: url)
    let result = try? JSONDecoder().decode(DataResult.self, from: data)
    return result
  }
}

enum NetworkError: Error {
  case badUrl
  case decodingError
  case badRequest
}
