//
//  CarPlanVC.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by kimhyungyu on 2021/11/16.
//

import UIKit

class CarPlanVC: UIViewController {
    
    // MARK: - Properties
    
    var reservationData: [ReservationResultData] = []
    var recommendContentList: [RecommendResultData] = []
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet var fromTextField: UITextField!
    @IBOutlet var toTextField: UITextField!
    @IBOutlet var reservationButton: UIButton!
    @IBOutlet var recommendCollectionView: UICollectionView!
    @IBOutlet var reservationStackView: UIStackView!
    @IBOutlet var applyView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet weak var defaultHistoryView: UIView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getReservationDataList()
        getRecommendDataList()
        editChanged()
        setPlaceholder()
        setTextField()
        setShadowingView()
        setStackView()
        assignRecommendCollectionView()
        registerXib()
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchReservationButton(_ sender: Any) {
        guard let filterVC = UIStoryboard(name: Const.Storyboard.Name.filter, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Identifier.filter) as? FilterVC else { return }
        
        filterVC.date.append(fromTextField.text!)
        filterVC.date.append(toTextField.text!)
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
    
    // MARK: - @objc Function

    @objc func textFieldCompleted(_ textField: UITextField) {
        reservationButton.isEnabled = fromTextField.hasText && toTextField.hasText
    }

    // MARK: - Custom Method
    
    func getReservationDataList() {
        ReservationService.shared.showReservation(userId: 0) { responseData in
            switch responseData {
            case .success(let reservationResponse):
                guard let response = reservationResponse as? ReservationResponseData else { return }
                
                if let data = response.data {
                    self.reservationData = data
                    self.setHistoryView()
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
    
    func getRecommendDataList() {
        RecommendDataService.shared.getRecommendInfo(userId: 3) { responseData in

            switch responseData {
            case .success(let recommendResponse):
                guard let response = recommendResponse as? RecommendResponseData else {return}
                if let response = response.data {
                    self.recommendContentList = response
                    print(response)
                    self.recommendCollectionView.reloadData()
                }
                case .requestErr(let msg):
                    print("requestErr \(msg)")
                case .pathErr:
                    print("pathErr")
                case .serverErr:
                    print("serverErr")
                case .networkFail:
                    print("networkFail")
                }
            }
    }

    func editChanged() {
        reservationButton.isEnabled = false
        [self.fromTextField, self.toTextField].forEach {
            $0?.addTarget(self, action: #selector(self.textFieldCompleted(_:)), for: .editingChanged)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setPlaceholder() {
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.gray040,
            NSAttributedString.Key.font: UIFont.body2R
        ]
        
        fromTextField.attributedPlaceholder = NSAttributedString(string: "YY/MM/DD", attributes: attributes)
        toTextField.attributedPlaceholder = NSAttributedString(string: "YY/MM/DD", attributes: attributes)
    }
    
    func setTextField() {

        fromTextField.font = UIFont.body2R
        toTextField.font = UIFont.body2R
    }
    
    func setShadowingView() {
        
        applyView.layer.applyShadow(color: .black, alpha: 0.1, x: 1, y: 1, blur: 7, spread: 0)
    }
    
    func setStackView() {
        messageLabel.text = "더 많은 쏘카를 대여해보세요!"
    }
    
    func addCustomView(day: String, week: String, mainAddress: String, subAddress: String, index: Int) {

        guard let loadedNib = Bundle.main.loadNibNamed(String(describing: ReservationHistoryView.self), owner: self, options: nil) else { return }
        guard let reservationHistory = loadedNib.first as? ReservationHistoryView else { return }
        
        reservationHistory.initView(day: day, week: week, mainAddress: mainAddress, subAddress: subAddress)
        reservationHistory.heightAnchor.constraint(equalToConstant: 58).isActive = true
        reservationStackView.insertArrangedSubview(reservationHistory, at: index)
    }
    
    func setHistoryView() {
        if reservationData.count == 4 {
            defaultHistoryView.removeFromSuperview()
        }
        for (index, data) in reservationData.enumerated() {
            addCustomView(day: data.date, week: data.date, mainAddress: data.address, subAddress: data.location, index: index)
        }
    }
    
    func assignRecommendCollectionView() {
        recommendCollectionView.dataSource = self
        recommendCollectionView.delegate = self
    }
    
    func registerXib() {
        recommendCollectionView.register(UINib(nibName: RecommendCarCVC.identifier, bundle: nil), forCellWithReuseIdentifier: RecommendCarCVC.identifier)
    }
}

// MARK: - Extensions

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}

extension CarPlanVC: UICollectionViewDelegate { }

extension CarPlanVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case recommendCollectionView:
            return recommendContentList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCarCVC.identifier, for: indexPath) as? RecommendCarCVC else {return UICollectionViewCell()}
        
        let url = URL(string: recommendContentList[indexPath.row].imageURL)
        let data = try? Data(contentsOf: url!)
        cell.carImageView.image = UIImage(data: data!)

        cell.nameLabel.text = recommendContentList[indexPath.row].carName
        cell.priceLabel.text = recommendContentList[indexPath.row].priceUnit + " " +  String(recommendContentList[indexPath.row].price) + "원~"
        cell.discountLabel.text = String(recommendContentList[indexPath.row].discountRate) + "%"
        
        return cell
    }

}

extension CarPlanVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case recommendCollectionView:
            return CGSize(width: (collectionView.frame.height * 248 / 188), height: collectionView.frame.height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case recommendCollectionView:
            return 8
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch collectionView {
        case recommendCollectionView:
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        default:
            return .zero
        }
        
    }

}
