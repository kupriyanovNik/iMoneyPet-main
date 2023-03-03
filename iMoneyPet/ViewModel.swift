//
//  ViewModel.swift
//  iMoneyPet
//
//  Created by Никита on 14.01.2023.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    
    @Published var spendingName: String = ""
    @Published var spendingAmount: String = ""
    @Published var selectedCategory = Categories.uncategorized
    @Published var selectedDate = Date()
    
    @Published var showTodayDetailView: Bool = false 
    
    @Published var currentExchangeRate = 77
    
    init() {
        self.fetch()
   }
    
    func reset() {
        self.spendingName = ""
        self.spendingAmount = ""
        self.selectedCategory = .uncategorized
        self.selectedDate = Date()
    }
    
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

