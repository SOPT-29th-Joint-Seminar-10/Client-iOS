//
//  ViewController.swift
//  SOPT-29th-JointSeminar10-iOS
//
//  Created by kimhyungyu on 2021/11/13.
//

import UIKit

class MainTabVC: UITabBarController {

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabar()
    }
}

// MARK: - Extensions

extension MainTabVC {
    private func setTabar() {
        guard let homeVC = self.storyboard?.instantiateViewController(withIdentifier: Const.ViewController.Identifier.home),
              let carPlanVC = self.storyboard?.instantiateViewController(withIdentifier: Const.ViewController.Identifier.carPlan),
              let pairingVC = self.storyboard?.instantiateViewController(withIdentifier: Const.ViewController.Identifier.pairing),
              let myPageVC = self.storyboard?.instantiateViewController(withIdentifier: Const.ViewController.Identifier.myPage) else { return }
        
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: .defaultHome, selectedImage: .selectedHome)
        carPlanVC.tabBarItem = UITabBarItem(title: "차량플랜", image: .defaultCarplan, selectedImage: .selectedCarplan)
        pairingVC.tabBarItem = UITabBarItem(title: "페어링", image: .defaultPairing, selectedImage: .selectedPairing)
        myPageVC.tabBarItem = UITabBarItem(title: "마이페이지", image: .defaultMypage, selectedImage: .selectedMypage)

        setViewControllers([homeVC, carPlanVC, pairingVC, myPageVC], animated: true)
        
        // set tabbar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        if #available(iOS 15.0, *) {
            appearance.backgroundColor = .white
            // remove tabbar border line
            appearance.shadowColor = UIColor.clear
            
            tabBar.standardAppearance = appearance
        } else {
            // TODO: - 13 시뮬레이터에서 되는지 확인해야함
            tabBar.isTranslucent = false
            tabBar.barTintColor = .white
            // remove tabbar border line
            appearance.shadowColor = UIColor.clear
            
            tabBar.standardAppearance = appearance
        }
        tabBar.tintColor = .black
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        tabBar.layer.applyShadow(color: .black,
                                 alpha: 0.3,
                                 x: 0,
                                 y: 0,
                                 blur: 12,
                                 spread: 0)
    }
}
