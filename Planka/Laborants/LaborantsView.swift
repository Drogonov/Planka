//
//  LaborantsView.swift
//  Planka
//
//  Created by Anton Vlezko on 22.10.2021.
//

import SwiftUI

struct LaborantsView: View {
    let laborants: [Laborant]
    var laborantDeleted: (Laborant) -> Void
    var laborantTapped: (Laborant) -> Void
    
    var body: some View {
        List {
            ForEach(laborants) { laborant in
                Button {
                    laborantTapped(laborant)

                } label: {
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.primary)
                            .frame(width: 32)
                        Text(laborant.name)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                }
            }
            .onDelete { row in
                guard let rowIndex = row.first else { return }
                laborantDeleted(laborants[rowIndex])
            }
        }
        .padding(.vertical, 16)
    }
}

struct LaborantsView_Previews: PreviewProvider {
    static var previews: some View {
        LaborantsView(laborants: [Laborant(name: "Иван"),
                                  Laborant(name: "Екатерина")],
                      laborantDeleted: { _ in },
                      laborantTapped: { _ in})
    }
}
