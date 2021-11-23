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
    
    @IBOutlet var rentalView: ReservationHistoryView!
    @IBOutlet var fromTextField: UITextField!
    @IBOutlet var toTextField: UITextField!
    @IBOutlet var reservationButton: UIButton!
    @IBOutlet var recommendCollectionView: UICollectionView!
    @IBOutlet var reservationStackView: UIStackView!
    @IBOutlet var applyView: UIView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editChanged()
        setPlaceholder()
        setTextField()
        setShadowingView()
        setRecommendCVCList()
        assignRecommendCollectionView()
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
        
        recommendCollectionView.layer.applyShadow(color: .black, alpha: 0.1, x: 1, y: 1, blur: 7, spread: 0)
        applyView.layer.applyShadow(color: .black, alpha: 0.1, x: 1, y: 1, blur: 7, spread: 0)
    }
    
    func setRecommendCVCList() {
        recommendCarModel.append(contentsOf: [
            RecommendCarModel(name: "더뉴아반떼", price: "연 550,0000원~ /", discount: "10 %", image: "imgThenewavante"),
            RecommendCarModel(name: "투싼(휘발유)", price: "연 403,0000원~ /", discount: "20 %", image: "imgTosan"),
            RecommendCarModel(name: "스포티지", price: "연 571,0000원~ /", discount: "25 %", image: "imgSportage")
        ])
        
        recommendCollectionView.isPagingEnabled = true
    }
    
    // TODO: - 서버에서 주는 히스토리 리스트의 개수에 따라서 추가해주기
    /*
     스택뷰 아래쪽으로 넣는 코드
     (고정된 높이 지정, count로 for문)
     */
    func addViewsInStackView() {
        //        var viewDataList : [[:]] = [[:]]()
        //        viewDataList.append()
        //
        //        for i in 0 ..< viewDataList.count {
        //            reservationStackView.addArrangedSubview(i)
        //        }
        
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

extension CarPlanVC {
    private func initRecommendCarCVC() {
        guard let loadedNib = Bundle.main.loadNibNamed(String(describing: RecommendCarCVC.self), owner: self, options: nil) else {return}
        guard let recommendCarCVC = loadedNib.first as? RecommendCarCVC else {return}
        
        rentalView = .init(day: "03", week: "wed", mainAddress: "서울특별시 관악구 신림로 29길 8", subAddress: "신림현대아파트 주차장")
        
        reservationStackView.addSubview(rentalView)
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
        
        cell.setDataWith(image: recommendCarModel[indexPath.item].image, name: recommendCarModel[indexPath.item].name, price: recommendCarModel[indexPath.item].price, discount: recommendCarModel[indexPath.item].discount)
        
        return cell
    }

}

extension CarPlanVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let width = collectionView.frame.width
//        let height = collectionView.frame.height
        
        switch collectionView {
        case recommendCollectionView:
//            return CGSize(width: (width * 248 / 188), height: height)
//            return CGSize(width: UIScreen.main.bounds.width * (248/188), height: height)
            // FIXME: - 셀 너비 비율로 대응하기
            return CGSize(width: 248, height: 188)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 8
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
