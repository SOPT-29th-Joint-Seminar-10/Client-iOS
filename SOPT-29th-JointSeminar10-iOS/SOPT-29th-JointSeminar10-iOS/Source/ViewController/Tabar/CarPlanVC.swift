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
    
    @IBOutlet var rentalView: UIView!
    @IBOutlet var fromTextField: UITextField!
    @IBOutlet var toTextField: UITextField!
    @IBOutlet var reservationButton: UIButton!
    @IBOutlet var recommendCollectionView: UICollectionView!
    @IBOutlet var reservationStackView: UIStackView!
    @IBOutlet var applyView: UIView!
    @IBOutlet var messageLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editChanged()
        setPlaceholder()
        setTextField()
        setShadowingView()
        setRecommendCVCList()
        addCustomView()
        addViewsInStackView()
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
        messageLabel.text = "더 많은 쏘카를 대여해보세요!"
    }
    
    func addCustomView() {

        guard let loadedNib = Bundle.main.loadNibNamed(String(describing: ReservationHistoryView.self), owner: self, options: nil) else {return}
        guard let reservationHistory = loadedNib.first as? ReservationHistoryView else {return}
        
        reservationHistory.frame = CGRect(x: 0, y: 0, width: reservationHistory.frame.width, height: reservationHistory.frame.height)
        reservationStackView.addSubview(reservationHistory)
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
