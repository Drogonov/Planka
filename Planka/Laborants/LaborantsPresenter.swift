//
//  LaborantsPresenter.swift
//  Planka
//
//  Created by Anton Vlezko on 22.10.2021.
//

import Foundation

protocol LaborantsPresenterProtocol: AnyObject {
    init(view: LaborantsViewProtocol, laborants: [Laborant])
    func addLaborant(laborant: Laborant)
    func deleteLaborant(laborant: Laborant)
}

class LaborantsPresenter: LaborantsPresenterProtocol {
    let view: LaborantsViewProtocol
    var laborants: [Laborant] = []
    
    required init(view: LaborantsViewProtocol, laborants: [Laborant]) {
        self.view = view
        self.laborants = laborants
    }
    
    func addLaborant(laborant: Laborant) {
        self.laborants.append(laborant)
        self.view.setLaborants(laborants: laborants)
    }
    
    func deleteLaborant(laborant: Laborant) {
        guard let index = laborants.firstIndex(where: {$0.id == laborant.id}) else { return }
        self.laborants.remove(at: index)
        self.view.setLaborants(laborants: laborants)
    }
}
