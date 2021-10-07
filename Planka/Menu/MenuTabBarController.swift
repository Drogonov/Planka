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
    
    lazy var companyVC = CompanyViewController()
    lazy var laborantsVC = LaborantsViewController()
    lazy var baseStationsVC = BaseStationsViewController()
    lazy var thermalRodsVC = ThermalRodsViewController()
    lazy var storageVC = StorageViewController()
    lazy var shopVC = ShopViewController()
    
    private var menuOptions: [MenuOptions] = []
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
    
    func selectedIndexChangedWith(index: Int) {
        selectedIndex = index
    }
    
    func addMenuOptions(options: [MenuOptions]) {
        menuOptions = options
        configureTabBar()
    }
}

// MARK: - Configure UI

extension MenuTabBarController {
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
        var viewControllersArray: [UIViewController] = []
        options.forEach { option in
            let rootViewController = constructViewControllerWithOption(option: option)
            let navController = constructNavController(
                rootViewController: rootViewController,
                option: option
            )
            viewControllersArray.append(navController)
        }
        return viewControllersArray
    }
    
    private func constructViewControllerWithOption(option: MenuOptions) -> UIViewController {
        switch option {
        case .company:
            return companyVC
        case .laborants:
            return laborantsVC
        case .baseStations:
            return baseStationsVC
        case .thermalRods:
            return thermalRodsVC
        case .storage:
            return storageVC
        case .shop:
            return shopVC
        }
    }
    
    private func constructNavController(rootViewController: UIViewController, option: MenuOptions) -> UINavigationController {
        configureViewControllerWithOption(
            rootViewController: rootViewController,
            option: option
        )
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.tintColor = .orange
        return navController
    }
    
    private func configureViewControllerWithOption(rootViewController: UIViewController, option: MenuOptions) {
        let image = UIImage(systemName: "list.bullet")!
        rootViewController.navigationItem.title = option.description
        rootViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(showMenu)
        )
    }
}
