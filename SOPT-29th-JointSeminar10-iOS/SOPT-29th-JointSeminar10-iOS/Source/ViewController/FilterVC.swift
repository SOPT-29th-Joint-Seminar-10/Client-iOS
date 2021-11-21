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
    
    let reserveContentList: [ReservationCarModel] = []
    let isFilteredList: [Int] = [0, 0, 0, 0, 0, 0]
    let beforeFiltered: [String] = ["초기화", "대여기간", "차종", "지역", "가격", "인기"]
    let afterFiltered: [String] = ["", "", "준중형", "서울/경기/인천", "낮은 가격 순", "인기"]
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        registerXib()
    }
    
    // MARK: - Custom Methods
    
    func setDelegate() {
        filterCV.delegate = self
        filterCV.dataSource = self
        reservationCV.delegate = self
        reservationCV.dataSource = self
    }
    
    func initAppContentList() {
        
        // TODO: - 서버 연결되면 데이터 넣기
        
    }
    
    func registerXib() {
        let filterXibName = UINib(nibName: Const.Xib.NibName.filterCVC, bundle: nil)
        filterCV.register(filterXibName, forCellWithReuseIdentifier: Const.Xib.NibName.filterCVC)
        let reservationXibName = UINib(nibName: Const.Xib.NibName.reservationCVC, bundle: nil)
        reservationCV.register(reservationXibName, forCellWithReuseIdentifier: Const.Xib.NibName.reservationCVC)
    }
}

// MARK: - Extensions

extension FilterVC: UICollectionViewDelegate {

}

extension FilterVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filterCV {
            return 6
        } else {
            
            // TODO: - 서버 붙이면 reservationContentList.count로 변경하기
            
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == filterCV {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.NibName.filterCVC, for: indexPath) as? FilterCVC else {return UICollectionViewCell()}
            cell.titleButton.setAttributedTitle(NSAttributedString(string:beforeFiltered[indexPath.row]), for: .normal)
            let attributedTitle = cell.titleButton.attributedTitle(for: .normal)
            
            cell.filterView.frame.size.width = attributedTitle!.size().width + 50
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.NibName.reservationCVC, for: indexPath) as? ReservationCVC else {return UICollectionViewCell()}
            
            return cell
        }
    }
}

extension FilterVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == filterCV {
            
            // TODO: - 내용에 따라 동적으로 크기 변경하기
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.NibName.filterCVC, for: indexPath) as? FilterCVC
            cell!.titleButton.setAttributedTitle(NSAttributedString(string:beforeFiltered[indexPath.row]), for: .normal)
            let attributedTitle = cell!.titleButton.attributedTitle(for: .normal)
            
            return CGSize(width: (attributedTitle?.size().width)! + 100, height: 32)
        } else {
            return CGSize(width: 168, height: 168)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == filterCV {
            return 0
        } else {
            return 7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == filterCV {
            return 4
        } else {
            return 11
        }
    }
}
