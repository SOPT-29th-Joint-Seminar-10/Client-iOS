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
    }
    
    // TODO: - registerXib() 구현하기
    
    func registerXib() {
        let xibName = UINib(nibName: <#T##String#>, bundle: <#T##Bundle?#>)
    }
}

// MARK: - Extensions

extension FilterVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
}

extension FilterVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
