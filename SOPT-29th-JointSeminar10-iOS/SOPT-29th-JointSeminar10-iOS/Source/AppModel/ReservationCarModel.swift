//
//  ReservationCarModel.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by kimhyungyu on 2021/11/16.
//

import UIKit

struct ReservationCarModel {
    let name: String
    let price: String
    let discount: String
    let term: String
    let location: String
    
    func setImage(_ image: String) -> UIImage {
        return UIImage(named: image) ?? UIImage()
    }
}
