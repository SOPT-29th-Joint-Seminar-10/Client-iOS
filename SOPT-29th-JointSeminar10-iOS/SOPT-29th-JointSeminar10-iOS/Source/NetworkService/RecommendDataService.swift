//
//  RecommendDataService.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by 정은희 on 2021/11/30.
//

import Foundation
import Alamofire

struct RecommendDataService
{
    static let shared = RecommendDataService()
    
    func getRecommendInfo(userId: Int,
                          completion: @escaping (NetworkResult<Any>) -> Void)

    {
        let URL = APIConstants.recommendURL
        let header: [String: Any] = [
            "Content-Type": "application/json",
            "userId": userId
        ]
        
        let dataRequest = AF.request(URL,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header.toHTTPHeaders())
        
        dataRequest.responseData { dataResponse in
            
            switch dataResponse.result {
                
            case .success:
                guard let statusCode = dataRequest.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeRecommendStatus(by: statusCode, value)
                completion(networkResult)
                
            case .failure: completion(.pathErr)
            }
        }
    }
    
    private func judgeRecommendStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        
        switch statusCode {
        case 200: return isValidData(data: data)
        case 400: return isUsedPathErrData(data: data)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func isValidData(data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(RecommendResponseData.self, from: data) else {return .pathErr}
        return .success(decodedData.data ?? "None-Data")
    }
    
    private func isUsedPathErrData(data: Data)  -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()

        guard let decodedData = try? decoder.decode(RecommendResponseData.self, from: data) else {return .pathErr}
        return .requestErr(decodedData)
    }
}
