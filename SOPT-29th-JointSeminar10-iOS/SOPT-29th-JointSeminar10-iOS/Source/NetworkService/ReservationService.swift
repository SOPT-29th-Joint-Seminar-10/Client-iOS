//
//  ReservationService.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by 박예빈 on 2021/11/29.
//

import Foundation
import Alamofire

struct ReservationService {
    static let shared = ReservationService()
    
    func showReservation(userId: Int,
                         completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = APIConstants.reservationURL
        
        let header: [String: Any] = [
            "Content-Type": "apllication/json",
            "userId": userId
        ]
    
        let dataRequest = AF.request(url,
                                     method: .get,
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
        let decoder = JSONDecoder()
        guard let decodeData = try? decoder.decode(ReservationResponseData.self, from: data) else { return .pathErr }
        switch statusCode {
        case 200: return .success(decodeData ?? "None-Data")
        case 400..<500: return .requestErr(decodeData.message)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
}
