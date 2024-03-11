//
//  CartStruct.swift
//  SalesLoop
//
//  Created by Jack Crane on 3/13/24.
//

import Foundation

struct Cart: Codable, Identifiable {
    let id: String
    let name: String
    let userId: String?
    let companyId: String?
    let active: Bool
    let deletedAt: String?
    let createdAt: Date
    let updatedAt: Date
    let products: [ProductInCart]
}

struct ProductInCart: Codable {
    let id: String
    let qty: Int
    let cartId: String
    let productId: String
    let createdAt: Date
    let updatedAt: Date
    let product: Product?
}

struct Product: Codable {
    let id: String
    let name: String
    let description: String
    let internalId: String
    let barcode: String
    let companyId: String
    let active: Bool
    let createdAt: Date
    let updatedAt: Date
}
