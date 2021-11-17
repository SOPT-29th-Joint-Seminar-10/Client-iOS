//
//  ReservationCVC.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by kimhyungyu on 2021/11/16.
//

import UIKit

class ReservationCVC: UICollectionViewCell {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
}


// MARK: - Extensions

extension ReservationCVC {
    private func setUI() {
        carImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .body1M
        priceLabel.font = .sub4M
        discountLabel.font = .body1M
        discountLabel.textColor = .blue040
        termLabel.font = .cap2R
        termLabel.textColor = .gray050
        locationLabel.font = .cap2R
        locationLabel.textColor = .gray050
        
        contentView.layer.cornerRadius = 5
        contentView.layer.applyShadow()
        
        heartButton.setImage(.icDefaultHeartIos, for: .normal)
        heartButton.setImage(.icSelectedHeartIos, for: .selected)
    }
    
    func setDataWith(image: UIImage?,
                     name: String,
                     price: String,
                     discount: String,
                     term: String,
                     location: String,
                     isHeartSelected: Bool) {
        carImageView.image = image
        nameLabel.text = name
        priceLabel.text = price
        discountLabel.text = discount
        termLabel.text = term
        locationLabel.text = location
        heartButton.isSelected = isHeartSelected
    }
}
