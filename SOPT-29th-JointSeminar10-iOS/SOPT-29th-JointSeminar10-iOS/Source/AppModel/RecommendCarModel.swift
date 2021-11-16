//
//  RecommendCarModel.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by kimhyungyu on 2021/11/16.
//

import UIKit

struct RecommendCarModel {
    let name: String
    let price: String
    let discount: String
    
    func setImage(_ image: String) -> UIImage {
        return UIImage(named: image) ?? UIImage()
    }
}
