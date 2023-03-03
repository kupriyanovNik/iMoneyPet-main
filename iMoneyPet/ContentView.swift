//
//  ContentView.swift
//  iMoneyPet
//
//  Created by Никита on 14.01.2023.
//

import SwiftUI
import StoreKit

struct ContentView: View {
    
    @State private var sCount = 0
    
    @Environment(\.requestReview) var requestReview
    
    @State private var showAddingView: Bool = false
    
    @EnvironmentObject var model: ViewModel
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var spendings: FetchedResults<Spend>
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
            VStack {
                if isSomeMoenySpended() {
                    NavigationView {
                    
                        List {
                            (
                                Text("\(Int(totalMoneyToday()))₽ ")
                                +
                                Text(LocalizedStringKey("today"))
                            )
                                .foregroundColor(.gray)
                            ForEach(spendings, content: { spend in
                                if isSomeMoenySpended() {
                                    SpendCell(name: spend.name!, amount: spend.amount, date: spend.date!, category: spend.category!)
                                        .environmentObject(model)
                                }
                            })
                            .onDelete(perform: deleteSpendings)
                            
                        }
                        .onChange(of: sCount) { newValue in
                            if newValue == 10 {
                                requestReview()
                            }
                        }
                        .refreshable {
                            model.fetch()
                        }
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button {
                                    self.showAddingView = true
                                } label: {
                                    Image(systemName: "plus")
                                }

                            }
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                EditButton()
                            }
                        }
                        .navigationTitle(LocalizedStringKey("spendText"))
                        .navigationBarTitleDisplayMode(.automatic)
                        .onAppear {
                            sCount = spendings.count
                        }
                    }
                } else {
                    NavigationView {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .frame(width: 150, height: 100)
                                .foregroundColor(Color.gray.opacity(0.3))
                            Button {
                                self.showAddingView = true
                            } label: {
                                Text(LocalizedStringKey("mainText"))
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .navigationTitle(LocalizedStringKey("spendText"))
                    }
                }
            }
            .sheet(isPresented: $showAddingView) {
                AddingView()
                    .environmentObject(model)
            }
        
    }
    fileprivate func isSomeMoenySpended() -> Bool {
        return !spendings.isEmpty
    }
    private func deleteSpendings(offsets: IndexSet) {
        withAnimation {
            offsets.map { spendings[$0] }
            .forEach(managedObjContext.delete)
            DataController().save(context: managedObjContext)
        }
    }
    private func totalMoneyToday() -> Int64 {
        var moneyToday: Int64 = 0
        for item in spendings {
            if let date = item.date {
                if Calendar.current.isDateInToday(date) {
                    moneyToday += item.amount
                }
            }
        }
        return moneyToday
    }
    private func totalMoney() -> Int64 {
        var money: Int64 = 0
        for item in spendings {
            money += item.amount
        }
        return money
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
