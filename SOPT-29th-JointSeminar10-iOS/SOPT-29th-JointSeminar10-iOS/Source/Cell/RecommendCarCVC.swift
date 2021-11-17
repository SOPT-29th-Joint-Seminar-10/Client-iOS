//
//  RecommendCarCVC.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by kimhyungyu on 2021/11/16.
//

import UIKit

class RecommendCarCVC: UICollectionViewCell {
    
    static let identifier = "RecommendCarCVC"

    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
}

// MARK: - Extensions

extension RecommendCarCVC {
    private func setUI() {
        carImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .sub4M
        priceLabel.font = .sub3B
        discountLabel.font = .sub3B
        discountLabel.textColor = .blue040
        
        contentView.layer.cornerRadius = 5
        contentView.layer.applyShadow()
    }
    
    func setDataWith(image: UIImage?, name: String, price: String, discount: String) {
        carImageView.image = image
        nameLabel.text = name
        priceLabel.text = price
        discountLabel.text = discount
    }
}
