//
//  DetailViewController.swift
//  Planka
//
//  Created by Anton Vlezko on 27.10.2021.
//

import Foundation
import UIKit
import SwiftUI

protocol DetailViewProtocol: AnyObject {
    func setLaborant(laborant: Laborant?)
}

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, laborant: Laborant?)
    func setLaborant()
}

class DetailViewPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    var laborant: Laborant?
    required init(view: DetailViewProtocol, laborant: Laborant?) {
        self.view = view
        self.laborant = laborant
    }
    
    func setLaborant() {
        self.view?.setLaborant(laborant: laborant)
    }
}

class DetailViewController: UIViewController {
    var laborant: Laborant?
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setLaborant()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        guard let laborant = laborant else {
            return
        }

        let detailView = DetailView(laborant: laborant)
        addDetailViewToVC(detailView: detailView)
    }
    
    private func addDetailViewToVC(detailView: DetailView) {
        let detailCtrl = UIHostingController(rootView: detailView)
        addChild(detailCtrl)
        view.addSubview(detailCtrl.view)
        
        detailCtrl.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.rightAnchor
        )
    }
}

extension DetailViewController: DetailViewProtocol {
    func setLaborant(laborant: Laborant?) {
        self.laborant = laborant
    }
}

struct DetailView: View {
    let laborant: Laborant
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text(laborant.name)
            Spacer()
        }
    }
}
