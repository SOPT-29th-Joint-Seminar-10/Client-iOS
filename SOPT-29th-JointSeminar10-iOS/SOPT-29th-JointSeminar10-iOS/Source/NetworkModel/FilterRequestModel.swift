//
//  FilterRequestModel.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by 박예빈 on 2021/12/02.
//

import Foundation

struct FilterRequestData {
    let userId: Int
    var start: String?
    var end: String?
    var type: String?
    var location: String?
    var price: String?
    var trend: String?
    
    init(userId: Int, start: String, end: String) {
        self.userId = userId
        self.start = start
        self.end = end
    }
    
    init() {
        self.userId = -1
        self.start = nil
        self.end = nil
        self.type = nil
        self.location = nil
        self.price = nil
        self.trend = nil
    }
    
    init(userId: Int) {
        self.userId = userId
    }
}
