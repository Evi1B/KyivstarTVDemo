//
//  APIClient.swift
//  DemoApp
//
//  Created by Bogdan Akopov on 02.01.2025.
//

import Foundation
import Combine

final class NetworkManager {
    private let baseUrl = "https://api.json-generator.com/templates"
    private let token = "b3kgsqs1kqytlpact6fhh6pd8grvdj7kqm0nkvd1"

    private func makeRequest(for endpoint: String) -> URLRequest {
        var request = URLRequest(url: URL(string: "\(baseUrl)\(endpoint)")!)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }

    func fetchPromotions() -> AnyPublisher<PromotionsResponse, Error> {
        let request = makeRequest(for: "/j_BRMrbcY-5W/data")
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: PromotionsResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchCategories() -> AnyPublisher<CategoriesResponse, Error> {
        let request = makeRequest(for: "/eO-fawoGqaNB/data")
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: CategoriesResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchContentGroups() -> AnyPublisher<[ContentGroup], Error> {
        let request = makeRequest(for: "/PGgg02gplft-/data")
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [ContentGroup].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchSimilarAssets() -> AnyPublisher<[SimilarAsset], Error> {
        let request = makeRequest(for: "/04Pl5AYhO6-n/data")
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: SimilarAssetResponse.self, decoder: JSONDecoder())
            .map { $0.similar }
            .eraseToAnyPublisher()
    }
}
