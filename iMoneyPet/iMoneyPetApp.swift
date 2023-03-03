//
//  iMoneyPetApp.swift
//  iMoneyPet
//
//  Created by Никита on 14.01.2023.
//

import SwiftUI

@main
struct iMoneyPetApp: App {
    @StateObject private var model = ViewModel()
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(model)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
