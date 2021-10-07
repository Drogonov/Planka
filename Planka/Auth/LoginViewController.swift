//
//  LoginViewController.swift
//  Planka
//
//  Created by Anton Vlezko on 07.10.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = UIColor.systemRed
        navigationItem.title = "Login"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Up", style: .plain, target: self, action: #selector(signUpTapped))
    }
    
    // MARK: - Selectors
    
    @objc func signUpTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
