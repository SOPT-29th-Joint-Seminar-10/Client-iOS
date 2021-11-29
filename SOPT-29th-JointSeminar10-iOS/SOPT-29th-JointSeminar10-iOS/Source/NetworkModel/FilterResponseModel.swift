//
//  FilterResponseModel.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by 박예빈 on 2021/11/29.
//

import Foundation

// MARK: - FilterResponseModel
struct FilterResponseModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [FilterResultModel]?
}

// MARK: - FilterResultModel
struct FilterResultModel: Codable {
    let carID: Int
    let carName, modelYear, priceUnit: String
    let price, discountRate: Int
    let currentLocation: String
    let imageURL: String
    let isLiked: Bool

    enum CodingKeys: String, CodingKey {
        case carID = "carId"
        case carName, modelYear, priceUnit, price, discountRate, currentLocation
        case imageURL = "imageUrl"
        case isLiked
    }
}

