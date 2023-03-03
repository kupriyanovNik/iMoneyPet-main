//
//  MainView.swift
//  iMoneyPet
//
//  Created by Никита on 14.01.2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var model: ViewModel
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var spendings: FetchedResults<Spend>
    var body: some View {
        if isSomeMoenySpended() {
            TabView {
                ContentView()
                    .environmentObject(model)
                    .tabItem {
                        Label(LocalizedStringKey("main"), systemImage: "house")
                    }
                DetailView()
                    .tabItem {
                        Label(LocalizedStringKey("expenses"), systemImage: "chart.bar")
                    }
            }
        } else {
            ContentView()
                .environmentObject(model)
        }
    }
}

extension MainView {
    fileprivate func isSomeMoenySpended() -> Bool {
        if spendings.count != 0 {
            return true
        } else {
            return false
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ViewModel())
    }
}
