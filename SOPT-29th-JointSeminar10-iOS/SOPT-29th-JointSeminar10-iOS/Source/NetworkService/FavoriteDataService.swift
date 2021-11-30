//
//  FavoriteDataService.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by 정은희 on 2021/12/01.
//

import Foundation
import Alamofire

struct FavoriteDataService {
    static let shared = FavoriteDataService()
    
    func liked(carID: Int,
               isLiked: Bool,
               completion: @escaping (NetworkResult<Any>) -> (Void)) {
        
        // 1. 데이터를 받아오기 위한 준비
        let url = APIConstants.favoriteURL
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        let body: Parameters = [
            "carID": carID,
            "isLiked": isLiked
        ]
        
        // 2. 통신을 위한 요청서 작성
        let dataRequest = AF.request(url,
                                     method: .put,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        // 3. 2번에서 정의한 요청서로 서버에 통신 request
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeClickedStatus(by: statusCode, value)
                completion(networkResult)
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    private func judgeClickedStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isVaildClickedData(data: data)
        case 400: return isUsedPathErrData(data: data)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func isVaildClickedData(data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(FavoriteResultData.self, from: data) else {return .pathErr}
        return .success(decodedData)
    }
    
    private func isUsedPathErrData(data: Data)  -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(FavoriteResultData.self, from: data) else {return .pathErr}
        return .requestErr(decodedData)
    }
}
