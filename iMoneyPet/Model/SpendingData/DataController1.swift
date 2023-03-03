//
//  DataController.swift
//  myMoney
//
//  Created by Никита on 12.08.2022.
//
//
//import Foundation
//import CoreData
//import SwiftUI
//
//class DataController: ObservableObject {
//
//    let container = NSPersistentContainer(name: "SpendingModel")
//
//    init() {
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                print("ошибка \(error.localizedDescription)")
//            }
//        }
//    }
//
//    func save(context: NSManagedObjectContext) {
//        do {
//            try context.save()
//            print("усмпешное сохранение")
//        } catch {
//
//            let nsError = error as NSError
//            fatalError("ошибка \(nsError) \(nsError.userInfo)")
//        }
//    }
//
//    func addSpending(name: String, amount: Double, context: NSManagedObjectContext) {
//        let food = Food(context: context)
//        food.id = UUID()
//        food.date = Date()
//        food.name = name
//        food.amount = amount
//
//        save(context: context)
//    }
    
//    func editSpending(spending: Spending, name: String, amount: Double, context: NSManagedObjectContext) {
//        spending.name = name
//        spending.amount = amount
//
//        save(context: context)
//    }
//}

