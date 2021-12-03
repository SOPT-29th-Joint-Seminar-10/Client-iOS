//
//  FavoriteResponseData.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by 정은희 on 2021/12/01.
//

import Foundation

// MARK: - FavoriteResponseData
struct FavoriteResponseData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: FavoriteResultData?
}

// MARK: - FavoriteResultData
struct FavoriteResultData: Codable {
    let carID: Int
    let isLiked: Bool

    enum CodingKeys: String, CodingKey {
        case carID = "carId"
        case isLiked
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        carID = (try? values.decode(Int.self, forKey: .carID)) ?? 0
        isLiked = (try? values.decode(Bool.self, forKey: .isLiked)) ?? false
    }
}
