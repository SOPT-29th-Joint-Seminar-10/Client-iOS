//
//  FilterRequestModel.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by 박예빈 on 2021/12/02.
//

import Foundation

struct FilterRequestData {
    let userId: Int
    let start: String?
    let end: String?
    let type: String?
    let location: String?
    let price: String?
    let trend: String?
}
