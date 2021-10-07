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
    private var menuOptions: [MenuOptions] = []
    
//    private lazy var companyVC = CompanyViewController()
//    private lazy var laborantsVC = LaborantsViewController()
    
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
        viewControllers = constructViewControllersArray(options: menuOptions)
        selectedIndex = 0
        tabBar.tintColor = .label
        tabBar.isHidden = true
    }
    
    private func constructViewControllersArray(options: [MenuOptions]) -> [UIViewController] {
        var vcArray: [UIViewController] = []
        options.forEach { option in
            let vc = constructViewControllerWithOption(option: option)
            let navVC = constructViewController(vc: vc, option: option)
            vcArray.append(navVC)
        }
        return vcArray
    }
    
    private func constructViewControllerWithOption(option: MenuOptions) -> UIViewController {
        switch option {
        case .company:
            return CompanyViewController()
        case .laborants:
            return LaborantsViewController()
        case .baseStations:
            return BaseStationsViewController()
        case .thermalRods:
            return ThermalRodsViewController()
        case .storage:
            return StorageViewController()
        case .shop:
            return ShopViewController()
        }
    }
    
    private func constructViewController(vc: UIViewController, option: MenuOptions) -> UINavigationController {
        return constructNavController(rootViewController: vc, option: option)
    }
    
    private func constructNavController(rootViewController: UIViewController, option: MenuOptions) -> UINavigationController {
        configureRootViewController(rootViewController: rootViewController, option: option)
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.tintColor = .orange
        return navController
    }
    
    private func configureRootViewController(rootViewController: UIViewController, option: MenuOptions) {
        let image = UIImage(systemName: "list.bullet")!
        rootViewController.navigationItem.title = option.description
        rootViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(showMenu)
        )
    }
    
    func selectedIndexChangedWith(index: Int) {
        selectedIndex = index
    }
    
    func addMenuOptions(options: [MenuOptions]) {
        menuOptions = options
        configureTabBar()
    }
}
