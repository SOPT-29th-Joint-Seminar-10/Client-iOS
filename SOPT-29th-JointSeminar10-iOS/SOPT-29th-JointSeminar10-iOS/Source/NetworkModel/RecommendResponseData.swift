//
//  RecommendResponseData.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by 정은희 on 2021/11/30.
//

import Foundation

// MARK: - RecommendResponseData
struct RecommendResponseData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [RecommendResultData]?
}

// MARK: - RecommendResultData
struct RecommendResultData: Codable {
    let carName, priceUnit: String
    let price, discountRate: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case carName, priceUnit, price, discountRate
        case imageURL = "imageUrl"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        carName = (try? values.decode(String.self, forKey: .carName)) ?? ""
        priceUnit = (try? values.decode(String.self, forKey: .priceUnit)) ?? ""
        price = (try? values.decode(Int.self, forKey: .price)) ?? 0
        discountRate = (try? values.decode(Int.self, forKey: .discountRate)) ?? 0
        imageURL = (try? values.decode(String.self, forKey: .imageURL)) ?? ""
    }
}


