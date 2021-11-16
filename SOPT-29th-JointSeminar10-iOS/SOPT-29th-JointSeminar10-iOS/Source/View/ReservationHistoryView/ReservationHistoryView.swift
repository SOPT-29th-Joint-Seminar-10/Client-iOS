//
//  ReservationHistoryView.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by kimhyungyu on 2021/11/16.
//

import Foundation
import UIKit

/**
 차량 플랜에서 히스토리 내역을 보여주는 커스텀 뷰
 */

class ReservationHistoryView: UIView {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var mainAddressLabel: UILabel!
    @IBOutlet weak var subAddressLabel: UILabel!
    
    // MARK: - Methods
    
    init(day: String,
         week: String,
         mainAddress: String,
         subAddress: String) {
        super.init(frame: .zero)
        setUI()
        
        dayLabel.text = day
        weekLabel.text = week
        mainAddressLabel.text = mainAddress
        subAddressLabel.text = subAddress
    }
    
    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
    }
    
    private func setUI() {
        dayLabel.font = .sub2M
        dayLabel.textColor = .gray070
        weekLabel.font = .cap2R
        weekLabel.textColor = .gray070
        mainAddressLabel.font = .sub2M
        mainAddressLabel.textColor = .gray070
        subAddressLabel.font = .cap2R
        subAddressLabel.textColor = .gray070
    }
    
}