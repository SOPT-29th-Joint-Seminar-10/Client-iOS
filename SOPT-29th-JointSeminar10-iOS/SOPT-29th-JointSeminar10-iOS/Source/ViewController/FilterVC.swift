//
//  FilterVC.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by 박예빈 on 2021/11/16.
//

import UIKit

import Kingfisher

class FilterVC: UIViewController {
    
    // MARK: - @IBOutlet Properties

    @IBOutlet weak var filterCV: UICollectionView!
    @IBOutlet weak var reservationCV: UICollectionView!
    @IBOutlet weak var filterView: UIView!
    
    // MARK: - Properties
    
    var reserveContentList: [FilterResultData] = []
    var isClickedFilter: [Int] = [0, 0, 0, 0, 0, 0]
    var date: [String] = []
    let beforeFiltered: [String] = ["초기화", "대여기간", "차종", "지역", "가격", "인기"]
    var afterFiltered: [String] = ["초기화", "3개월 | 2021", "준중형", "서울/경기/인천", "낮은 가격 순", "인기"]
    var requestData: FilterRequestData = FilterRequestData()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initContentList()
        setDelegate()
        registerXib()
        setUI()
    }
    
    // MARK: - Custom Methods
    
    func initContentList() {
        afterFiltered[1] = date[0] + " ~ "
        requestData = FilterRequestData(userId: 3, start: date[0], end: date[1])
        isClickedFilter[1] = 1
        
        print(requestData)
        
        FilterService.shared.filter(parameter: requestData) { responseData in
            switch responseData {
            case .success(let filterResponse):
                guard let response = filterResponse as? FilterResponseData else {return}
                
                if let response = response.data {
                    self.reserveContentList = response
                    print("##")
                    print(response)
                    self.reservationCV.reloadData()
                    self.filterCV.reloadData()
                }
            case .requestErr(let msg):
                print("requestErr \(msg)")
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serveErr")
            case .networkFail :
                print("networkFail")
            }
        }
    }
    
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
    
        if indexPath.row == 0 { // 초기화인 경우
            requestData = FilterRequestData(userId: 3)
            isClickedFilter = [0, 0, 0, 0, 0, 0]
        } else if isClickedFilter[indexPath.row] == 0 {
            var sendParameter: FilterRequestData = requestData
            
            isClickedFilter[indexPath.row] = 1
            
            switch indexPath.row {
            case 1: // 대여 기간
                sendParameter.start = date[0]
                sendParameter.end = date[1]
            case 2: // 차종
                sendParameter.type = "준중형"
            case 3: // 지역
                sendParameter.location = "서울/경기/인천"
            case 4: // 가격
                sendParameter.price = "desc"
            case 5: // 인기
                sendParameter.trend = "true"
            default:
                print("none")
            }
            requestData = sendParameter
            
        } else {
            var sendParameter: FilterRequestData = requestData
            
            isClickedFilter[indexPath.row] = 0
            
            switch indexPath.row {
            case 1: // 대여 기간
                sendParameter.start = nil
                sendParameter.end = nil
            case 2: // 차종
                sendParameter.type = nil
            case 3: // 지역
                sendParameter.location = nil
            case 4: // 가격
                sendParameter.price = nil
            case 5: // 인기
                sendParameter.trend = nil
            default:
                print("none")
            }
            requestData = sendParameter

        }
        print(requestData)
        
        FilterService.shared.filter(parameter: requestData) { responseData in
            switch responseData {
            case .success(let filterResponse):
                guard let response = filterResponse as? FilterResponseData else {return}
                
                if let response = response.data {
                    self.reserveContentList = response
                    print(response)
                }
                
                self.reservationCV.reloadData()
                self.filterCV.reloadData()
            case .requestErr(let msg):
                print("requestErr \(msg)")
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serveErr")
            case .networkFail :
                print("networkFail")
            }
        }
    }
}

extension FilterVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filterCV {
            return 6
        } else {
            print(reserveContentList.count)
            return reserveContentList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == filterCV {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.NibName.filterCVC, for: indexPath) as? FilterCVC else {return UICollectionViewCell()}
           
            if isClickedFilter[indexPath.row] == 1 {
                cell.closeButton.setImage(UIImage(named: "icFilterClose"), for: .normal)
                cell.closeButton.widthAnchor.constraint(equalToConstant: 37).isActive = true
                cell.closeButton.leadingAnchor.constraint(equalTo: cell.titleButton.trailingAnchor, constant: -30).isActive = true
                
                let attribute = [NSAttributedString.Key.font: UIFont.cap1R, NSAttributedString.Key.foregroundColor: UIColor.white]
                cell.titleButton.setAttributedTitle(NSAttributedString(string:afterFiltered[indexPath.row], attributes: attribute), for: .normal)
                
                cell.layer.backgroundColor = UIColor.gray060.cgColor
                cell.layer.borderWidth = 0
                cell.layer.cornerRadius = 0.042 * filterView.bounds.size.width
                
                cell.titleButton.setTitleColor(UIColor.white, for: .normal)
                
                let attributedTitle = cell.titleButton.attributedTitle(for: .normal)
                cell.titleButton.frame.size.width = attributedTitle!.size().width + 25
                cell.layer.frame.size.width = cell.titleButton.frame.size.width + 37
                
               if indexPath.row == 5 {
                    cell.titleButton.setImage(UIImage(named: "icSelectedPopular"), for: .normal)
                    cell.layer.frame.size.width = attributedTitle!.size().width + 30 + 15 + 8
                    cell.titleButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 0)
                    cell.titleButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
                }
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
                    cell.titleButton.setImage(UIImage(named: "icFilterIns"), for: .normal)
                    cell.titleButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 0)
                    cell.titleButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
                    cell.layer.frame.size.width = attributedTitle!.size().width + 30 + 15
                } else if indexPath.row == 5 {
                    cell.titleButton.setImage(UIImage(named: "icDefaultPopular"), for: .normal)
                    cell.layer.frame.size.width = attributedTitle!.size().width + 30 + 15
                    cell.titleButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 0)
                    cell.titleButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
                }
            }
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.NibName.reservationCVC, for: indexPath) as? ReservationCVC else {return UICollectionViewCell()}
        
            cell.setDataWith(url: reserveContentList[indexPath.row].imageURL,
                             name: reserveContentList[indexPath.row].carName,
                             price: String(reserveContentList[indexPath.row].price) + "원~",
                             discount: String(reserveContentList[indexPath.row].discountRate) + "%",
                             term: reserveContentList[indexPath.row].modelYear,
                             location: reserveContentList[indexPath.row].currentLocation,
                             isHeartSelected: reserveContentList[indexPath.row].isLiked)
            cell.carID = reserveContentList[indexPath.row].carID
            
            cell.heartCellDelegate = self
            return cell
        }
    }
}

extension FilterVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == filterCV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.NibName.filterCVC, for: indexPath) as? FilterCVC
           
            if isClickedFilter[indexPath.row] == 1 {
                cell!.closeButton.setImage(UIImage(named: "icFilterClose"), for: .normal)
                cell!.closeButton.widthAnchor.constraint(equalToConstant: 37).isActive = true
                cell!.closeButton.leadingAnchor.constraint(equalTo: cell!.titleButton.trailingAnchor, constant: -30).isActive = true
                
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
                
                if indexPath.row == 5 {
                     cell!.titleButton.setImage(UIImage(named: "icSelectedPopular"), for: .normal)
                     cell!.layer.frame.size.width = attributedTitle!.size().width + 30 + 15 + 8
                    cell!.titleButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 0)
                    cell!.titleButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
                }
                
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
                    cell!.titleButton.setImage(UIImage(named: "icFilterIns"), for: .normal)
                    cell!.layer.frame.size.width = attributedTitle!.size().width + 30 + 15
                    cell!.titleButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 0)
                    cell!.titleButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
                } else if indexPath.row == 5 {
                    cell!.titleButton.setImage(UIImage(named: "icDefaultPopular"), for: .normal)
                    cell!.layer.frame.size.width = attributedTitle!.size().width + 30 + 15
                    cell!.titleButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 0)
                    cell!.titleButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
                }
            }
            
            return CGSize(width: cell!.layer.frame.size.width, height: 32)
        } else {
            guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
            let numberOfCellsOfWidth: CGFloat = 2
            let width = collectionView.frame.size.width - (flowLayout.minimumInteritemSpacing * (numberOfCellsOfWidth-1))
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

// MARK: - HeartCellDelegate

extension FilterVC: HeartCellDelegate {
    func heartCellDelegateWith(carID: Int, isLiked: Bool) {
        
        FavoriteDataService.shared.putFavoriteInfo(userID: 3, carID: carID, isLiked: !isLiked) { responseData in
            switch responseData {
            case .success(let favoriteResponse):
                guard let response = favoriteResponse as? FavoriteResponseData else {return}
                
                if let response = response.data {
                    for index in 0..<self.reserveContentList.count {
                        if response.carID == self.reserveContentList[index].carID {
                            self.reserveContentList[index].isLiked = response.isLiked
                            break
                        }
                    }
                    self.reservationCV.reloadData()
                }
            case .requestErr(let msg):
                print("requestErr \(msg)")
            case .pathErr :
                print("pathErr")
            case .serverErr :
                print("serveErr")
            case .networkFail :
                print("networkFail")
            }
        }
    }
}
