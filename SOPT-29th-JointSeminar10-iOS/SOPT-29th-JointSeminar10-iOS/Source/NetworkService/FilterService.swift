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
    
    func filter(parameter: FilterRequestData,
                completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = APIConstants.filterURL
        
        let header: [String: Any] = [
            "Content-Type": "apllication/json",
            "userId": parameter.userId
        ]
        
        let parameters: Parameters = getParameter(parameter: parameter)
        
        print(parameters)
        
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
        guard let decodeData = try? decoder.decode(FilterResponseData.self, from: data) else { return .pathErr }
        switch statusCode {
        case 200: return .success(decodeData)
        case 400..<500: return .requestErr(decodeData.message)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    func getParameter(parameter: FilterRequestData) -> Parameters {
        
        var parameters: Parameters = [:]
        
        if parameter.start != nil {
            parameters["start"] = parameter.start
        }
        if parameter.end != nil {
            parameters["end"] = parameter.end
        }
        if parameter.type != nil {
            parameters["type"] = parameter.type
        }
        if parameter.location != nil {
            parameters["location"] = parameter.location
        }
        if parameter.price != nil {
            parameters["price"] = parameter.price
        }
        if parameter.trend != nil {
            parameters["trend"] = "true"
        } else {
            parameters["trend"] = nil
        }
        
        return parameters
    }
}
