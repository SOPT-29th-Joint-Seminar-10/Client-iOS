//
//  CarPlanVC.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by kimhyungyu on 2021/11/16.
//

import UIKit

class CarPlanVC: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet var firstRentalView: UIView!
    @IBOutlet var secondRentalView: UIView!
    @IBOutlet var thridRentalView: UIView!
    @IBOutlet var fourthRentalView: UIView!
    @IBOutlet var fromTextField: UITextField!
    @IBOutlet var toTextField: UITextField!
    @IBOutlet var reservationButton: UIButton!
    

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editChanged()
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
