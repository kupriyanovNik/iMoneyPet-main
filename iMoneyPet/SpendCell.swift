//
//  SpendCell.swift
//  iMoneyPet
//
//  Created by Никита on 22.01.2023.
//

import SwiftUI

struct SpendCell: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var model: ViewModel
    var name: String
    var amount: Int64
    var date: Date
    var category: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .bold()
                Text("\(Int(amount)) ₽")
            }
            .contextMenu {
                    Text((date.formatted()))
                Text("\(String(format: "%.2f", Double(amount) / Double(model.currentExchangeRate))) EUR")
            }
            Spacer()
            Text(LocalizedStringKey(category))
                .foregroundColor(colorScheme == .dark ? .mint.opacity(0.5) : .orange.opacity(0.5))
            
        }
        
    }
}
