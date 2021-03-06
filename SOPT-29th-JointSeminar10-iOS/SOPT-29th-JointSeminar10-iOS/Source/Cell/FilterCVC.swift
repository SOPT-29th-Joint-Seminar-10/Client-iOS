//
//  FilterCVC.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by 박예빈 on 2021/11/17.
//

import UIKit

class FilterCVC: UICollectionViewCell {
    
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    func setUI() {
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        titleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        titleButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.leadingAnchor.constraint(equalTo: titleButton.trailingAnchor).isActive = true
        closeButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        closeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        closeButton.widthAnchor.constraint(lessThanOrEqualToConstant: 0).isActive = true
        
    }

}
