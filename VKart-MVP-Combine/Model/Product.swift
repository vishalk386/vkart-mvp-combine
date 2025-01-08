//
//  Product.swift
//  VKart-MVP-Combine
//
//  Created by Vishal Kamble on 08/01/25.
//

import Foundation

struct Rating: Decodable {
    let rate: Double
    let count: Int
}


struct Product: Decodable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let image: String
    let category: String
    let rating: Rating?
}
