//
//  Reservation.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by 박예빈 on 2021/11/28.
//

import Foundation

// MARK: - ReservationResponseData
struct ReservationResponseData: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [ReservationResultData]?
}

// MARK: - ReservationResultData
struct ReservationResultData: Codable {
    let date, location, address: String
}
