//
//  Dictionary+Extension.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by 박예빈 on 2021/11/29.
//

import Foundation
import Alamofire

extension Dictionary where Key == String, Value == Any {
    func toHTTPHeaders() -> HTTPHeaders {
        HTTPHeaders(mapValues { String(describing: $0) })
    }
}
