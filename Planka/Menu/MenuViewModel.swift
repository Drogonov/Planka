//
//  MenuViewModel.swift
//  Planka
//
//  Created by Anton Vlezko on 07.10.2021.
//

import Foundation

class MenuViewModel {
    let menuOptions: [MenuOptions] = [
        .company,
        .laborants,
        .baseStations,
        .thermalRods,
        .storage,
        .shop
    ]
    
    var isExpanded = false
}

enum MenuOptions: CustomStringConvertible {
    case company
    case laborants
    case baseStations
    case thermalRods
    case storage
    case shop
    
    var description: String {
        switch self {
        case .company: return "Компания"
        case .laborants: return "Лаборанты"
        case .baseStations: return "Базовые станции"
        case .thermalRods: return "Термоштанги"
        case .storage: return "Склады"
        case .shop: return "Магазин"
        }
    }
    
    var index: Int {
        switch self {
        case .company: return 0
        case .laborants: return 1
        case .baseStations: return 2
        case .thermalRods: return 3
        case .storage: return 4
        case .shop: return 5
        }
    }
}
