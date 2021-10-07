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
    
    let menuButtons: [MenuOptions] = [.company, .laborants]
    weak var delegate: MenuViewControllerDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
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
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureMenu()
    }
    
    func configureMenu() {
        let menuView = MenuView(
            menuButtons: menuButtons,
            buttonTapped: { option in
                self.delegate?.menuButtonTappedWithOption(option: option)
            }
        )
        addMenuToVC(menuView: menuView)
    }
    
    func addMenuToVC(menuView: MenuView) {
        let menuCtrl = UIHostingController(rootView: menuView)
        addChild(menuCtrl)
        view.addSubview(menuCtrl.view)
        
        menuCtrl.view.anchor(
            top: view.topAnchor,
            leading: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.rightAnchor,
            paddingRight: 80
        )
    }
}
