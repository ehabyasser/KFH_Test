//
//  RateResponse.swift
//  IBAN_Validation
//
//  Created by Ihab yasser on 21/05/2023.
//

import Foundation
struct RateResponse: Codable {
    let success: Bool?
    let query: Query?
    let info: Info?
    let date: String?
    let historical: Bool?
    let result: Double?
}

// MARK: - Info
struct Info: Codable {
    let timestamp: Int?
    let rate: Double?
}

// MARK: - Query
struct Query: Codable {
    let from, to: String?
    let amount: Int?
}
