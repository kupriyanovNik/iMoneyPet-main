//
//  TodayView.swift
//  iMoneyPet
//
//  Created by Никита on 22.01.2023.
//

import SwiftUI

struct TodayView: View {
    @EnvironmentObject var model: ViewModel
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var spendings: FetchedResults<Spend>
    var body: some View {
        List(spendings) { spend in
            SpendCell(name: spend.name!, amount: spend.amount, date: spend.date!, category: spend.category!)
        }
    }
}


struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
            .environmentObject(ViewModel())
    }
}
