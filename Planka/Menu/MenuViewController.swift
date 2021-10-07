//
//  MenuViewController.swift
//  Planka
//
//  Created by Anton Vlezko on 07.10.2021.
//

import UIKit
import SwiftUI

protocol MenuViewControllerDelegate: AnyObject {
    func menuButtonTappedWithOption(option: MenuOptions)
    func handleTabBarToogle()
}

class MenuViewController: UIViewController {
    
    // MARK: - Properties
    
    private var menuOptions: [MenuOptions] = []
    weak var delegate: MenuViewControllerDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc private func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .left {
            delegate?.handleTabBarToogle()
        }
    }
    
    private func configureSwipeGesture() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    // MARK: - Helper Functions
    
    func addMenuOptions(options: [MenuOptions]) {
        menuOptions = options
        configureMenu()
    }
}

// MARK: - Configure UI

extension MenuViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureMenu()
    }
    
    private func configureMenu() {
        let menuView = MenuView(
            menuButtons: menuOptions,
            buttonTapped: { option in
                self.delegate?.menuButtonTappedWithOption(option: option)
            }
        )
        addMenuToVC(menuView: menuView)
    }
    
    private func addMenuToVC(menuView: MenuView) {
        let menuCtrl = UIHostingController(rootView: menuView)
        addChild(menuCtrl)
        view.addSubview(menuCtrl.view)
        
        menuCtrl.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.rightAnchor,
            paddingRight: 80
        )
    }
}
