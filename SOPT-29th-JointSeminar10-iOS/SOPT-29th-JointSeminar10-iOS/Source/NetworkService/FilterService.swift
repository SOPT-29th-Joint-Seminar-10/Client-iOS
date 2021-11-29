//
//  FilterService.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by 박예빈 on 2021/11/29.
//

import Foundation
import Alamofire

struct FilterService {
    static let shared = FilterService()
    
    func filter(userId: Int,
                start: String,
                end: String,
                type: String?,
                location: String?,
                price: String?,
                trend: Bool?,
                completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = addParameter(url: APIConstants.filterURL, type: type, location: location, price: price, trend: trend)
        
        let header: [String: Any] = [
            "Content-Type": "apllication/json",
            "userId": userId
        ]
        
        let parameters: Parameters = [
            "start": start,
            "end" : end
        ]

        let dataRequest = AF.request(url,
                                     method: .get,
                                     parameters: parameters,
                                     encoding: URLEncoding.queryString,
                                     headers: header.toHTTPHeaders())
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataRequest.response?.statusCode else { return }
                guard let value = dataResponse.value else { return }
                let networkResult = self.judgeReservationStatus(by: statusCode, value)
                completion(networkResult)
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    // 📌 400 - 499 상태코드 대응.
    private func judgeReservationStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodeData = try? decoder.decode(ReservationResponseData.self, from: data) else { return .pathErr }
        switch statusCode {
        case 200: return .success(decodeData)
        case 400..<500: return .requestErr(decodeData.message)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
}
