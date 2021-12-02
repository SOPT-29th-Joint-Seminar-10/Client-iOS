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
    
    func putFavoriteInfo(carID: Int,
                         isLiked: Bool,
                         completion: @escaping (NetworkResult<Any>) -> (Void)) {
        
        let url = APIConstants.favoriteURL
        print(url)
        dump(url)
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let body: Parameters = [
            "carID": carID,
            "isLiked": isLiked
        ]
        let dataRequest = AF.request(url,
                                     method: .put,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { dataResponse in
            print(dataResponse)
            dump(dataResponse)
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeClickedStatus(by: statusCode, value)
                completion(networkResult)
                print(networkResult)
                
            case .failure(let err):
                print(err)
                print("----------------")
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
