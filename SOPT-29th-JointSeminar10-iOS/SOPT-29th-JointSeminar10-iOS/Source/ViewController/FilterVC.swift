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
    @IBOutlet weak var filterView: UIView!
    
    let reserveContentList: [ReservationCarModel] = []
    var isClickedFilter: [Int] = [0, 0, 0, 0, 0, 0]
    let beforeFiltered: [String] = ["초기화", "대여기간", "차종", "지역", "가격", "인기"]
    let afterFiltered: [String] = ["초기화", "3개월 | 2021", "준중형", "서울/경기/인천", "낮은 가격 순", "인기"]
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        registerXib()
        setUI()
    }
    
    // MARK: - Custom Methods
    
    func setUI() {
        self.navigationItem.title = "차량 예약"
        self.navigationItem.backButtonTitle = ""
        let backbutton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .done, target: self, action: #selector(touchNavBackButton))
        self.navigationItem.leftBarButtonItem = backbutton
        
        self.filterView.layer.applyShadow(color: .black, alpha: 0.04, x: 0, y: 3.62319, blur: 3.62319, spread: 0)
        
    }
    
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
    
    // MARK: - @objc functions
    
    @objc func touchNavBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extensions

extension FilterVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isClickedFilter[indexPath.row] == 0 {
            isClickedFilter[indexPath.row] = 1
        } else {
            isClickedFilter[indexPath.row] = 0
        }
        collectionView.reloadData()
    }
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
           
            if isClickedFilter[indexPath.row] == 1 {
                cell.closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
                cell.closeButton.widthAnchor.constraint(equalToConstant: 37).isActive = true
                cell.closeButton.leadingAnchor.constraint(equalTo: cell.titleButton.trailingAnchor, constant: -20).isActive = true
                
                let attribute = [NSAttributedString.Key.font: UIFont.cap1R, NSAttributedString.Key.foregroundColor: UIColor.white]
                cell.titleButton.setAttributedTitle(NSAttributedString(string:afterFiltered[indexPath.row], attributes: attribute), for: .normal)
                
                cell.layer.backgroundColor = UIColor.gray060.cgColor
                cell.layer.borderWidth = 0
                cell.layer.cornerRadius = 0.042 * filterView.bounds.size.width
                
                cell.titleButton.setTitleColor(UIColor.white, for: .normal)
                
                let attributedTitle = cell.titleButton.attributedTitle(for: .normal)
                cell.titleButton.frame.size.width = attributedTitle!.size().width + 25
                cell.layer.frame.size.width = cell.titleButton.frame.size.width + 37
            } else {
                cell.closeButton.setImage(UIImage(), for: .normal)
                
                let attribute = [NSAttributedString.Key.font: UIFont.cap1R, NSAttributedString.Key.foregroundColor: UIColor.gray060]
                cell.titleButton.setAttributedTitle(NSAttributedString(string:beforeFiltered[indexPath.row], attributes: attribute), for: .normal)
                
                cell.layer.backgroundColor = UIColor.white.cgColor
                cell.layer.borderWidth = 1.3
                cell.layer.cornerRadius = 0.042 * filterView.bounds.size.width
                cell.layer.borderColor = UIColor.gray040.cgColor
                
                cell.titleButton.setTitleColor(UIColor.gray060, for: .normal)
                
                let attributedTitle = cell.titleButton.attributedTitle(for: .normal)
                cell.layer.frame.size.width = attributedTitle!.size().width + 30
                
                if indexPath.row == 0{
                    cell.titleButton.setImage(UIImage(named: "defaultHome"), for: .normal)
                    cell.layer.frame.size.width = attributedTitle!.size().width + 30 + 15
                } else if indexPath.row == 5 {
                    cell.titleButton.setImage(UIImage(named: "group17"), for: .normal)
                    cell.layer.frame.size.width = attributedTitle!.size().width + 30 + 15
                }
            }
            
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.NibName.filterCVC, for: indexPath) as? FilterCVC
           
            if isClickedFilter[indexPath.row] == 1 {
                cell!.closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
                cell!.closeButton.widthAnchor.constraint(equalToConstant: 37).isActive = true
                cell!.closeButton.leadingAnchor.constraint(equalTo: cell!.titleButton.trailingAnchor, constant: -10).isActive = true
                
                let attribute = [NSAttributedString.Key.font: UIFont.cap1R, NSAttributedString.Key.foregroundColor: UIColor.white]
                cell!.titleButton.setAttributedTitle(NSAttributedString(string:afterFiltered[indexPath.row], attributes: attribute), for: .normal)
               
                cell!.layer.backgroundColor = UIColor.gray060.cgColor
                cell!.layer.borderWidth = 0
                cell!.layer.cornerRadius = 0.042 * filterView.bounds.size.width
                cell!.layer.borderColor = UIColor.gray040.cgColor
                
                cell!.titleButton.setTitleColor(UIColor.white, for: .normal)
                
                let attributedTitle = cell!.titleButton.attributedTitle(for: .normal)
                cell!.titleButton.frame.size.width = attributedTitle!.size().width + 25
                cell!.layer.frame.size.width = cell!.titleButton.frame.size.width + 37
                
            } else {
                cell!.closeButton.setImage(UIImage(), for: .normal)
                
                let attribute = [NSAttributedString.Key.font: UIFont.cap1R, NSAttributedString.Key.foregroundColor: UIColor.gray060]
                cell!.titleButton.setAttributedTitle(NSAttributedString(string:beforeFiltered[indexPath.row], attributes: attribute), for: .normal)
                
                cell!.layer.backgroundColor = UIColor.white.cgColor
                cell!.layer.borderWidth = 1.3
                cell!.layer.cornerRadius = 0.042 * filterView.bounds.size.width
                
                cell!.titleButton.setTitleColor(UIColor.gray060, for: .normal)
                
                let attributedTitle = cell!.titleButton.attributedTitle(for: .normal)
                cell!.layer.frame.size.width = attributedTitle!.size().width + 30
                
                if indexPath.row == 0 {
                    cell!.titleButton.setImage(UIImage(named: "defaultHome"), for: .normal)
                    cell!.layer.frame.size.width = attributedTitle!.size().width + 30 + 15
                } else if indexPath.row == 5 {
                    cell!.titleButton.setImage(UIImage(named: "group17"), for: .normal)
                    cell!.layer.frame.size.width = attributedTitle!.size().width + 30 + 15
                }
            }
            
            return CGSize(width: cell!.layer.frame.size.width, height: 32)
        } else {
            guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
            let numberOfCellsOfWidth: CGFloat = 2
            let numberOfCellsOfHeight: CGFloat = 5
            let width = collectionView.frame.size.width - (flowLayout.minimumInteritemSpacing * (numberOfCellsOfWidth-1))
            let height = collectionView.frame.size.height - (flowLayout.minimumLineSpacing * (numberOfCellsOfHeight-1))
            return CGSize(width: width/(numberOfCellsOfWidth), height: width/(numberOfCellsOfWidth))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == filterCV {
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        } else {
            return UIEdgeInsets.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == filterCV {
            return 4
        } else {
            return 7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == filterCV {
            return 0
        } else {
            return 11
        }
    }
}
