//
//  ContainerViewController.swift
//  Planka
//
//  Created by Anton Vlezko on 07.10.2021.
//

import UIKit

protocol ContainerViewControllerDelegate: AnyObject {
    func menuTabIndexChanged(index: Int)
}

class ContainerViewController: UIViewController {
    
    // MARK: - Properties
    
    let menuButtons: [MenuOptions] = [
        .company,
        .laborants,
        .baseStations,
        .thermalRods,
        .storage,
        .shop
    ]
    
    private var loginVC = LoginViewController()
    private lazy var menuVC = MenuViewController()
    private var menuTabBar = MenuTabBarController()
    
    weak var delegate: ContainerViewControllerDelegate?
    
    private var isExpanded = false
    private let blackView = UIView()
    private lazy var xOrigin = self.view.frame.width - 80
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func dismissMenu() {
        isExpanded = false
        animateMenu(shouldExpand: isExpanded)
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureMenuVC()
        configureMenuTabBar()
    }
    
    private func configureMenuTabBar() {
        menuTabBar.tabBarDelegate = self
        menuTabBar.addMenuOptions(options: menuButtons)
        
        addChild(menuTabBar)
        menuTabBar.didMove(toParent: self)
        view.addSubview(menuTabBar.view)
        configureBlackView()
    }
    
    private func configureMenuVC() {
        menuVC.delegate = self
        menuVC.addMenuOptions(options: menuButtons)
        
        addChild(menuVC)
        menuVC.didMove(toParent: self)
        view.addSubview(menuVC.view)
    }
    
    func configureBlackView() {
        self.blackView.frame = CGRect(
            x: xOrigin,
            y: 0,
            width: 80,
            height: self.view.frame.height
        )
        blackView.backgroundColor = UIColor(
            white: 0,
            alpha: 0.5
        )
        blackView.alpha = 0
        view.addSubview(blackView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissMenu))
        blackView.addGestureRecognizer(tap)
    }
    
    func animateMenu(shouldExpand: Bool, completion: ((Bool) -> Void)? = nil) {
        if shouldExpand {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.menuTabBar.view.frame.origin.x = self.xOrigin
                self.blackView.frame.origin.x = self.xOrigin
                self.blackView.alpha = 1
            }, completion: nil)
        } else {
            self.blackView.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.menuTabBar.view.frame.origin.x = 0
                self.blackView.frame.origin.x = 0
            }, completion: completion)
        }
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    func handleTabBarToogle() {
        isExpanded.toggle()
        animateMenu(shouldExpand: isExpanded)
    }
    
    func menuButtonTappedWithOption(option: MenuOptions) {
        menuTabBar.selectedIndexChangedWith(index: option.index)
        isExpanded.toggle()
        animateMenu(shouldExpand: isExpanded)
    }
}

extension ContainerViewController: MenuTabBarControllerDelegate {
    func handleMenuToggle() {
        isExpanded.toggle()
        animateMenu(shouldExpand: isExpanded)
    }
}
