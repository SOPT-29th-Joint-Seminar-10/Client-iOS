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
        setUI()
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
    }
    
    private func setUI() {
        let appearance = UITabBarAppearance()
        // set tabbar opacity
        appearance.configureWithOpaqueBackground()
        
        // remove tabbar border line
        appearance.shadowColor = UIColor.clear
        
        // set tabbar background color
        appearance.backgroundColor = .white

        tabBar.standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            // set tabbar opacity
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
        tabBar.tintColor = .black
        tabBar.layer.applyShadow(color: .black,
                                 alpha: 0.3,
                                 x: 0,
                                 y: 0,
                                 blur: 12,
                                 spread: 0)
    }
}
