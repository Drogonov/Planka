//
//  LaborantsViewController.swift
//  Planka
//
//  Created by Anton Vlezko on 07.10.2021.
//

import UIKit
import SwiftUI

class LaborantsViewController: UIViewController {
    // MARK: - Properties
    var presenter: LaborantsPresenterProtocol!
    var laborants: [Laborant] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func addLaborant() {
        configureAddAlert()
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureLaborantsView()
        configureNavigationController()
    }
    
    private func configureNavigationController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add",
            style: .plain,
            target: self,
            action: #selector(addLaborant)
        )
    }
    
    private func configureLaborantsView() {
        let laborantsView = LaborantsView(
            laborants: laborants,
            laborantDeleted: { laborant in
                self.presenter.deleteLaborant(laborant: laborant)
            }
        )
        addLaborantsViewToVC(laborantsView: laborantsView)
    }
    
    private func addLaborantsViewToVC(laborantsView: LaborantsView) {
        let laborantsCtrl = UIHostingController(rootView: laborantsView)
        addChild(laborantsCtrl)
        view.addSubview(laborantsCtrl.view)
        
        laborantsCtrl.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.rightAnchor
        )
    }
    
    private func configureAddAlert() {
        configureAddModelAlert(title: "Хотите добавить еще одного лаборанта?",
                               message: "Заполните поле ниже",
                               textFieldNamePlaceholder: "Введите имя",
                               textFieldActionText: "Сохранить",
                               rejectActionText: "Отмена") { config, laborantName in
            switch config {
            case .textField:
                guard let name = laborantName else { return }
                let laborant = Laborant(name: name)
                self.presenter.addLaborant(laborant: laborant)
            default: break
            }
        }
    }
}

extension LaborantsViewController: LaborantsViewProtocol {
    func setLaborants(laborants: [Laborant]) {
        self.laborants = laborants
        configureUI()
    }
}
