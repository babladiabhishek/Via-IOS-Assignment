//
//  DataViewModel.swift
//  ViaplayAssignment
//
//  Created by Abhishek Babladi on 2022-11-06.
//

import Foundation

protocol ResultManagerDelegate {
    func didUpdateWithResult(_ dataManager: DataViewModel, result: DataInfoViewModel)
    func didFailWithError(error: Error)
}

class DataViewModel {
    var delegate: ResultManagerDelegate?
    var dataResult: DataInfoViewModel!

    func getData() async {
        do {
            guard let url = URL(string: "https://content.viaplay.com/ios-se") else {
                throw NetworkError.badUrl
            }
            let dataRes = try await Webservice().performRequest(url: url)
            self.dataResult = dataRes.map(DataInfoViewModel.init)
            self.delegate?.didUpdateWithResult(self, result: self.dataResult)
        } catch {
            self.delegate?.didFailWithError(error: error)
        }
    }
}

struct DataInfoViewModel {
    let dataInfo: DataResult
}
