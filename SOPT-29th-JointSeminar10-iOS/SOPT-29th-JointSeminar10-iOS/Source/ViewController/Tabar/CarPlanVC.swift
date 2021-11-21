//
//  CarPlanVC.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by kimhyungyu on 2021/11/16.
//

import UIKit

class CarPlanVC: UIViewController {
    
    // MARK: - Properties
    
    var recommendCarModel: [RecommendCarModel] = []
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet var firstRentalView: UIView!
    @IBOutlet var secondRentalView: UIView!
    @IBOutlet var thridRentalView: UIView!
    @IBOutlet var fourthRentalView: UIView!
    @IBOutlet var fromTextField: UITextField!
    @IBOutlet var toTextField: UITextField!
    @IBOutlet var reservationButton: UIButton!
    @IBOutlet var recommendCollectionView: UICollectionView!
    @IBOutlet var reservationStackView: UIStackView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editChanged()
        
        setPlaceholder()
        setTextField()
        
        initRecommendCarModel()
        setCollectionView()
        registerXib()
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchReservationButton(_ sender: Any) {
        guard let filterVC = UIStoryboard(name: Const.Storyboard.Name.filter, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Identifier.filter) as? FilterVC else { return }
        
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
    
    // MARK: - @objc Function

    @objc func textFieldCompleted(_ textField: UITextField) {
        reservationButton.isEnabled = fromTextField.hasText && toTextField.hasText
    }

    // MARK: - Custom Method

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
            NSAttributedString.Key.font: UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)!
        ]
        
        fromTextField.attributedPlaceholder = NSAttributedString(string: "YY/MM/DD", attributes: attributes)
        toTextField.attributedPlaceholder = NSAttributedString(string: "YY/MM/DD", attributes: attributes)
    }
    
    func setTextField() {

        fromTextField.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        toTextField.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
    }
    
    func initRecommendCarModel() {
        recommendCarModel.append(contentsOf: [
            RecommendCarModel(name: "더뉴아반떼", price: "연 550,0000원~ /", discount: "10 %"),
            RecommendCarModel(name: "투싼(휘발유)", price: "연 403,0000원~ /", discount: "20 %"),
            RecommendCarModel(name: "스포티지", price: "연 571,0000원~ /", discount: "25 %")
        ])
    }
    
    // FIXME: - case 경우들
    func addSubView() {
        //        switch reservationStackView {
        //        case 첫번째 예약:
        //            reservationStackView.addSubview(firstRentalView)
        //        case 두번째 예약:
        //            reservationStackView.addSubView(secondRentalView)
        //        case 세번째 예약:
        //            reservationStackView.addSubView(thridRentalView)
        //        case 네번째 예약:
        //            reservationStackView.addSubView(fourthRentalView)
        //        default:
        //            reservationStackView.isHidden
        //        }
        
    }
    
    func setCollectionView() {
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

extension CarPlanVC {
    private func initRecommendCarCVC() {
        guard let loadedNib = Bundle.main.loadNibNamed(String(describing: RecommendCarCVC.self), owner: self, options: nil) else {return}
        guard let recommendCarCVC = loadedNib.first as? RecommendCarCVC else {return}
        
        recommendCarCVC.frame = CGRect(x: 162, y: 707, width: recommendCollectionView.frame.width, height: recommendCollectionView.frame.height)
        recommendCollectionView.addSubview(recommendCarCVC)
    }
}

extension CarPlanVC {
    private func initReservationHistoryView() {
        guard let loadedNib = Bundle.main.loadNibNamed(String(describing: ReservationHistoryView.self), owner: self, options: nil) else {return}
        guard let reservationHistoryView = loadedNib.first as? ReservationHistoryView else {return}
        
        reservationHistoryView.frame = CGRect(x: 549, y: 309, width: reservationHistoryView.frame.width, height: reservationHistoryView.frame.height)
        reservationHistoryView.addSubview(reservationStackView)
    }
}

extension CarPlanVC: UICollectionViewDelegate { }

extension CarPlanVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case recommendCollectionView:
            return recommendCarModel.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCarCVC.identifier, for: indexPath) as? RecommendCarCVC else {return UICollectionViewCell()}
        
        cell.setDataWith(image: recommendCarModel[indexPath.row].setImage(recommendCarModel[indexPath.item].name), name: recommendCarModel[indexPath.item].name, price: recommendCarModel[indexPath.item].price, discount: recommendCarModel[indexPath.item].discount)
        
        return cell
    }

}

extension CarPlanVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSpacing: CGFloat = 8
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        switch collectionView {
        case recommendCollectionView:
            return CGSize(width: (width * 318 / 229) + itemSpacing, height: height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch collectionView {
        case recommendCollectionView:
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        default:
            return .zero
        }
        
    }

}
