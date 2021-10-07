//
//  MenuTabBarController.swift
//  Planka
//
//  Created by Anton Vlezko on 07.10.2021.
//

import UIKit

protocol MenuTabBarControllerDelegate: AnyObject {
    func handleMenuToggle()
}

class MenuTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Properties
    private lazy var companyVC = CompanyViewController()
    private lazy var laborantsVC = LaborantsViewController()
    
    weak var tabBarDelegate: MenuTabBarControllerDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func showMenu() {
        tabBarDelegate?.handleMenuToggle()
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            tabBarDelegate?.handleMenuToggle()
        }
    }
    
    private func configureSwipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureTabBar()
    }
    
    private func configureTabBar() {
        viewControllers = constructViewControllersArray()
        selectedIndex = 0
        tabBar.tintColor = .label
        tabBar.isHidden = true
    }
    
    private func constructViewControllersArray() -> [UIViewController] {
        let companyNavController = constructNavController(
            rootViewController: companyVC
        )
        
        let laborantsNavController = constructNavController(
            rootViewController: laborantsVC
        )
        
        return [companyNavController, laborantsNavController]
    }
    
    private func constructNavController(rootViewController: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        
        let image = UIImage(systemName: "list.bullet")!
        rootViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(showMenu)
        )
        return navController
    }
    
    func selectedIndexChangedWith(index: Int) {
        selectedIndex = index
    }
}
