//
//  ContentView.swift
//  DatePickerTextField
//
//  Created by 黃佳俊 on 2022/5/12.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ViewModel

    init() {
        _viewModel = StateObject(wrappedValue: ViewModel())
    }

    var body: some View {
        VStack {
            Form {
                Section("Date") {
                    DatePickerTextField(placeholder: "input date", pickerType: .inline, date: self.$viewModel.selectedData)
                }
            }
        }
    }
}

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var selectedData: Date? = Date()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
