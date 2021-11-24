//
//  TempUserSignService.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by kimhyungyu on 2021/11/24.
//

import Foundation

import Alamofire

// 📌 service 예시.
struct TempUserSignService {
    static let shared = TempUserSignService()
    
    func login(email: String,
               password: String,
               completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = APIConstants.loginURL
        
        let header: HTTPHeaders = [
            "Content-Type": "apllication/json"
        ]
        
        let body: Parameters = [
            "email": email,
            "password": password
        ]
        
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataRequest.response?.statusCode else { return }
                guard let value = dataResponse.value else { return }
                let networkResult = self.judgeLoginStatus(by: statusCode, value)
                completion(networkResult)
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    // 📌 400 - 499 상태코드 대응.
    private func judgeLoginStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodeData = try? decoder.decode(TempLoginResponseData.self, from: data) else { return .pathErr }
        switch statusCode {
        case 200: return .success(decodeData.data ?? "None-Data")
        case 400..<500: return .requestErr(decodeData.messgae)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
}
