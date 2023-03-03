//
//  AddingView.swift
//  iMoneyPet
//
//  Created by Никита on 14.01.2023.
//

import SwiftUI

struct AddingView: View {
    @EnvironmentObject var model: ViewModel
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.presentationMode) var presentationMode

    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section(header: Text(LocalizedStringKey("information"))) {
                        TextField(LocalizedStringKey("name"), text: $model.spendingName)
                            .submitLabel(.next)
                            .focused($focusedField, equals: .name)
                            .onSubmit {
                                focusedField = .amount
                            }
                        TextField(LocalizedStringKey("amount"), text: $model.spendingAmount)
                            .keyboardType(.numberPad)
                            .textContentType(.shipmentTrackingNumber)
                            .focused($focusedField, equals: .amount)
                    }
                    Section(header: Text(LocalizedStringKey("category"))) {
                        HStack {
                            Text(LocalizedStringKey("category"))
                            Spacer()
                            Picker("", selection: $model.selectedCategory) {
                                ForEach(Categories.allCases, id: \.self) { value in
                                    Text(LocalizedStringKey(value.rawValue))
                                }
                            }
                            .pickerStyle(.menu)
                        }
                    }
                    Section(header: Text(LocalizedStringKey("datentime"))) {
                        DatePicker(LocalizedStringKey("datentime"), selection: $model.selectedDate, in: ...Date())
                    }
                    Section(header: Text(LocalizedStringKey("adding"))) {
                        HStack {
                            Spacer()
                            Button(action: {
                                addButton()
                            }, label: {
                                Label(LocalizedStringKey("add"), systemImage: "square.and.arrow.down.on.square")
                            })
                            .padding(30)
                            Spacer()
                        }
                    }
                }
                .navigationTitle(LocalizedStringKey("newSpend"))
            }
            .onChange(of: model.selectedCategory) { _ in
                hideKeyboard()
            }
            .onAppear {
                model.selectedDate = Date()
            }
        }
    }
    func addButton() {
        if model.spendingName != "", model.spendingAmount != "" {
            DataController().addSpending(name: String(model.spendingName), date: model.selectedDate, amount: (String(model.spendingAmount).count <= 15) ? Int64(model.spendingAmount)! : Int64(Int64.max - 1), category: model.selectedCategory.rawValue, context: managedObjContext)
            print(DataController().container)
            
            withAnimation {
                self.presentationMode.wrappedValue.dismiss()
            }
            model.reset()
        } else {
            
        }
    }
}

struct AddingView_Previews: PreviewProvider {
    static var previews: some View {
        AddingView()
            .environmentObject(ViewModel())
    }
}


extension AddingView {
    enum FocusedField {
        case name
        case amount
    }
}
