//
//  FilterVC.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by 박예빈 on 2021/11/16.
//

import UIKit

class FilterVC: UIViewController {
    
    // MARK: - @IBOutlet Properties

    @IBOutlet weak var filterCV: UICollectionView!
    @IBOutlet weak var reservationCV: UICollectionView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterCV.delegate = self
        filterCV.dataSource = self
        reservationCV.delegate = self
        reservationCV.dataSource = self
        
        registerXib()
    }
    
    // TODO: - registerXib() 구현하기
    
    func registerXib() {
        let xibName = UINib(nibName: Const.Xib.NibName.reservationCVC, bundle: nil)
        filterCV.register(xibName, forCellWithReuseIdentifier: Const.Xib.NibName.reservationCVC)
        reservationCV.register(xibName, forCellWithReuseIdentifier: Const.Xib.NibName.reservationCVC)
    }
}

// MARK: - Extensions

extension FilterVC: UICollectionViewDelegate {

}

extension FilterVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.NibName.reservationCVC, for: indexPath) as? ReservationCVC else {return UICollectionViewCell()}
        
        return cell
    }
    
    
}
