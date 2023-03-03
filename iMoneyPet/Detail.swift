//
//  Detail.swift
//  iMoneyPet
//
//  Created by Никита on 14.01.2023.
//

import SwiftUI

struct DetailView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var spendings: FetchedResults<Spend>
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        NavigationView {
            ZStack {
                Color(colorScheme == .light ?  UIColor.secondarySystemBackground : .black)
                BarChartView(data: ChartData(values: [
                    ("???", countMoneyToCategory(for: .uncategorized))
                    , (NSLocalizedString("food", comment: ""), countMoneyToCategory(for: .food))
                    , (NSLocalizedString("devices", comment: ""), countMoneyToCategory(for: .devices))
                    , (NSLocalizedString("entertainments", comment: ""), countMoneyToCategory(for: .entertainments))
                    , (NSLocalizedString("car", comment: ""), countMoneyToCategory(for: .car))
                    , (NSLocalizedString("dwelling", comment: ""), countMoneyToCategory(for: .dwelling))
                    , (NSLocalizedString("animals", comment: ""), countMoneyToCategory(for: .animals))
                    , (NSLocalizedString("health", comment: ""), countMoneyToCategory(for: .health))
                    , (NSLocalizedString("clothes", comment: ""), countMoneyToCategory(for: .clothes))
                ]), title: NSLocalizedString("expenses", comment: ""), legend: "По категориям", style: Styles.barChartStyleNeonBlueLight, form: ChartForm.extraLarge, dropShadow: false, valueSpecifier: "%.0f", animatedToBack: true)
            }
            .ignoresSafeArea()
            .navigationTitle(LocalizedStringKey("expenseTracking"))
        }
    }
}

extension DetailView {
    func countMoneyToCategory(for category: Categories) -> Int {
        var counter: Int = 0
        for spend in spendings {
            if spend.category == category.rawValue {
                counter += Int(spend.amount)
            }
        }
        return counter
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

