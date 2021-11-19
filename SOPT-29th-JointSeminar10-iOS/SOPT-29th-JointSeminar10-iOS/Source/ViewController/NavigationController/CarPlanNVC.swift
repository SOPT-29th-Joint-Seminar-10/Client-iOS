//
//  CarPlanNVC.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by 박예빈 on 2021/11/20.
//

import UIKit

class CarPlanNVC: UINavigationController {
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let carPlanVC = self.storyboard?.instantiateViewController(withIdentifier: Const.ViewController.Identifier.carPlan) else { return }
        self.pushViewController(carPlanVC, animated: true)
    }

}
