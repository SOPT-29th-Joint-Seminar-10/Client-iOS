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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initView(day: String,
         week: String,
         mainAddress: String,
         subAddress: String) {
        setUI()

        dayLabel.text = day
        weekLabel.text = week
        mainAddressLabel.text = mainAddress
        subAddressLabel.text = subAddress
    }
    
// 🪓 xib 를 custom class 의 class 로 지정하면 init() 에서 사용하면 앱이 멈춤.
//    func customInit() {
//        if let view = Bundle.main.loadNibNamed("ReservationHistoryView", owner: self, options: nil)?.first as? UIView {
//            view.frame = self.bounds
//            addSubview(view)
//        }
//    }
    
    private func setUI() {
        dayLabel.font = .sub2M
        dayLabel.textColor = .gray070
        weekLabel.font = .cap2R
        weekLabel.textColor = .gray070
        subAddressLabel.font = .sub2M
        subAddressLabel.textColor = .gray070
        mainAddressLabel.font = .cap2R
        mainAddressLabel.textColor = .gray070
    }
    
    @IBInspectable override var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
}
