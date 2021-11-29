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
                type: String,
                location: String,
                price: String,
                trend: String,
                completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = APIConstants.filterURL
        
        let header: [String: Any] = [
            "Content-Type": "apllication/json",
            "userId": userId
        ]
        
        let parameters: Parameters = getParameter(start: start, end: end, type: type, location: location, price: price, trend: trend)
        
        print(parameters)
        
        let dataRequest = AF.request(url,
                                     method: .get,
                                     parameters: parameters,
                                     encoding: JSONEncoding.default,
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
        print(data)
        let decoder = JSONDecoder()
        guard let decodeData = try? decoder.decode(ReservationResponseData.self, from: data) else { return .pathErr }
        switch statusCode {
        case 200: return .success(decodeData)
        case 400..<500: return .requestErr(decodeData.message)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    func getParameter(start: String,
                      end: String,
                      type: String,
                      location: String,
                      price: String,
                      trend: String) -> Parameters {
        
        var parameters: Parameters = [
            "start": start,
            "end" : end
        ]
        
        if type != "" {
            parameters["type"] = type
        }
        if location != "" {
            parameters["location"] = location
        }
        if price != "" {
            parameters["price"] = price
        }
        
        if trend != "" {
            parameters["trend"] = true
        } else {
            parameters["trend"] = false
        }
        
        
        
        return parameters
    }
}
