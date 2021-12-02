//
//  APIConstants.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by kimhyungyu on 2021/11/24.
//

import Foundation

struct APIConstants {
    
    // MARK: - Base URL
    
    static let baseURL = "https://asia-northeast3-socar-server-814e9.cloudfunctions.net/api"
    
    static let recommendURL = baseURL + "/my/recommend"
    static let reservationURL = baseURL + "/my/rent"
    static let filterURL = baseURL + "/reserve"
}
