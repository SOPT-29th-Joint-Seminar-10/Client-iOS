//
//  TempLoginResponseData.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by kimhyungyu on 2021/11/24.
//

import Foundation

// 📌 response data 예시.
struct TempLoginResponseData: Codable {
    let status: Int
    let success: Bool
    let messgae: String
    let data: TempLoginResultData?
}

struct TempLoginResultData: Codable {
    let userID: Int
    let name, email: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case name, email
    }
    
    // 📌 서버에서 key-value 가 넘어오지 않아 디코딩할 수 없어서 nil 인 경우에 값 설정.
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userID = (try? values.decode(Int.self, forKey: .userID)) ?? 0
        name = (try? values.decode(String.self, forKey: .name)) ?? ""
        email = (try? values.decode(String.self, forKey: .email)) ?? ""
    }
}
