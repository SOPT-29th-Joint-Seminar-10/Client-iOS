//
//  ReservationCVC.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by kimhyungyu on 2021/11/16.
//

import UIKit
import Kingfisher

class ReservationCVC: UICollectionViewCell {
    
    // MARK: - Properties
    
    var heartCellDelegate: HeartCellDelegate?
    var carID: Int?
    
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
    
    override var isSelected: Bool {
        didSet{
            if isSelected == true {
                heartButton.imageView?.image = UIImage(systemName: "icSelectedHeartIos")
            } else {
                heartButton.imageView?.image = UIImage(systemName: "icDefaultHeartIos")
            }
        }
    }
    
    @IBAction func touchLikedButton(_ sender: Any) {
        heartCellDelegate?.heartCellDelegateWith(carID: carID ?? 0, isLiked: heartButton.isSelected)
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
    
    func setDataWith(url: String,
                     name: String,
                     price: String,
                     discount: String,
                     term: String,
                     location: String,
                     isHeartSelected: Bool) {
        if let url = URL(string: url) {
            carImageView.kf.setImage(with: url)
        }
        nameLabel.text = name
        priceLabel.text = price
        discountLabel.text = discount
        termLabel.text = term
        locationLabel.text = location
        heartButton.isSelected = isHeartSelected
    }
    
}
