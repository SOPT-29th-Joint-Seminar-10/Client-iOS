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
              let carPlanVC =  self.storyboard?.instantiateViewController(withIdentifier: Const.ViewController.Identifier.carPlan),
              let pairingVC = self.storyboard?.instantiateViewController(withIdentifier: Const.ViewController.Identifier.pairing),
              let myPageVC = self.storyboard?.instantiateViewController(withIdentifier: Const.ViewController.Identifier.myPage) else { return }
        let carPlanNVC = UINavigationController(rootViewController: carPlanVC)
        
        // TODO: - 네비게이션 바 iOS 15 미만 대응
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()    // 불투명하게
        appearance.backgroundColor = UIColor.white
        appearance.shadowColor = .white
        appearance.shadowImage = UIImage()
        appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.sub2M]
        carPlanNVC.navigationBar.standardAppearance = appearance
        carPlanNVC.navigationBar.scrollEdgeAppearance = carPlanNVC.navigationBar.standardAppearance    // 동일하게 만들기
        carPlanNVC.navigationBar.tintColor = UIColor.gray070
        
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: .defaultHome, selectedImage: .selectedHome)
        carPlanNVC.tabBarItem = UITabBarItem(title: "차량플랜", image: .defaultCarplan, selectedImage: .selectedCarplan)
        pairingVC.tabBarItem = UITabBarItem(title: "페어링", image: .defaultPairing, selectedImage: .selectedPairing)
        myPageVC.tabBarItem = UITabBarItem(title: "마이페이지", image: .defaultMypage, selectedImage: .selectedMypage)

        setViewControllers([homeVC, carPlanNVC, pairingVC, myPageVC], animated: true)
        self.selectedIndex = 1
        
    }
    
    // set tabbar appearance
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
