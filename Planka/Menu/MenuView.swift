//
//  MenuView.swift
//  Planka
//
//  Created by Anton Vlezko on 07.10.2021.
//

import SwiftUI

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
