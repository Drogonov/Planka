//
//  LaborantsBuilder.swift
//  Planka
//
//  Created by Anton Vlezko on 22.10.2021.
//

import Foundation
import UIKit

protocol Builder {
    static func createLaborantsModule() -> UIViewController
    static func createDetailModule(laborant: Laborant?) -> UIViewController
}

class ModelBuilder: Builder {
    static func createDetailModule(laborant: Laborant?) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailViewPresenter(view: view, laborant: laborant)
        view.presenter =  presenter
        return view
    }
    
    static func createLaborantsModule() -> UIViewController {
        let model: [Laborant] = []
        let view = LaborantsViewController()
        let presenter = LaborantsPresenter(view: view, laborants: model)
        view.presenter = presenter
        return view
    }
}
