//
//  SenatorsList.swift
//  USSenators
//
//  Created by Abdullah Alseddiq on 1/14/21.
//

import Foundation

// MARK: - Senators
struct Senators: Codable {
    let meta: Meta
    let objects: [Object]
}

// MARK: - Meta
struct Meta: Codable {
    let limit, offset, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case limit, offset
        case totalCount = "total_count"
    }
}
