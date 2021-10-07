//
//  MenuView.swift
//  Planka
//
//  Created by Anton Vlezko on 07.10.2021.
//

import SwiftUI

enum MenuOptions: CustomStringConvertible {
    case company
    case laborants
    
    var description: String {
        switch self {
        case .company: return "Компания"
        case .laborants: return "Лаборанты"
        }
    }
    
    var index: Int {
        switch self {
        case .company: return 0
        case .laborants: return 1
        }
    }
}

struct MenuView: View {
    let menuButtons: [MenuOptions]
    var buttonTapped: (MenuOptions) -> Void
    
    var body: some View {
        List {
            ForEach(menuButtons, id: \.self) { item in
                Button {
                    buttonTapped(item)
                } label: {
                    Text(item.description)
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(menuButtons: [.company, .laborants],
                 buttonTapped: {_ in })
    }
}
