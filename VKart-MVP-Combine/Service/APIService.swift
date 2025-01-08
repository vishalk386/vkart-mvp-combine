//
//  APIService.swift
//  VKart-MVP-Combine
//
//  Created by Vishal Kamble on 08/01/25.
//

import Foundation
import Combine

protocol APIServiceProtocol{
    func fetchData()-> AnyPublisher<[Product],Error>
}

class APIService:APIServiceProtocol{
    func fetchData() -> AnyPublisher<[Product], any Error> {
        guard let url = URL(string: Constant.baseURL)else{
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Product].self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
