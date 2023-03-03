//
//  iMoneyPetApp.swift
//  iMoneyPet
//
//  Created by Никита on 14.01.2023.
//

import Foundation
import SwiftUI

struct Welcome: Decodable {
    let date: String
    let info: Info
    let query: Query
    let result: Double
    let success: Bool
}

struct Info: Codable {
    let rate: Double
    let timestamp: Int
}

struct Query: Codable {
    let amount: Int
    let from: String
    let to: String
}

extension ViewModel {
    func fetch() {
        let url = "https://api.apilayer.com/fixer/convert?to=RUB&from=EUR&amount=1"
        var request = URLRequest(url: URL(string: url)!, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue("0smSu1jFhcfWkFdLnd7bUoWsS4Pe8CC8", forHTTPHeaderField: "apikey")
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error {
                    print(error.localizedDescription)
                } else {
                    let decoder = JSONDecoder()
                    if let data = data, let exchange = try? decoder.decode(Welcome.self, from: data) {
                        self?.currentExchangeRate = Int(exchange.result)
                    }
                }
            }
        }
        task.resume()
    }
}
