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
        VStack(alignment: .center) {
            Text("Меню")
                .foregroundColor(.primary)
                .font(.headline)
            
            List {
                ForEach(menuButtons, id: \.self) { item in
                    Button {
                        buttonTapped(item)
                    } label: {
                        HStack {
                            Image(systemName: item.systemImage)
                                .foregroundColor(.primary)
                                .frame(width: 32)
                            Text(item.description)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                    }
                }
            }
        }
        .padding(.vertical, 16)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(menuButtons: [.company, .laborants],
                 buttonTapped: {_ in })
    }
}
