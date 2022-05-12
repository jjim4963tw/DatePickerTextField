//
//  DatePickerTextField.swift
//  MyWidget
//
//  Created by 黃佳俊 on 2022/5/5.
//

import Foundation
import SwiftUI

struct DatePickerTextField: UIViewRepresentable {
    public var placeholder: String
    public var pickerType: UIDatePickerStyle
    
    @Binding public var date: Date?

    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    
    func makeCoordinator() -> DatePickerTextField.Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: UIViewRepresentableContext<DatePickerTextField>) -> UITextField {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = pickerType
        datePicker.frame = CGRect(x: 0, y: 36 + 50, width: UIScreen.main.bounds.size.width, height: 420)
        datePicker.addTarget(context.coordinator, action: #selector(context.coordinator.dateValueChanged), for: .valueChanged)
        
        textField.placeholder = placeholder
        textField.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        let rightButton = UIBarButtonItem(barButtonSystemItem: .done, target: context.coordinator, action: #selector(context.coordinator.doneButtonTapped))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.setItems([flexible, rightButton], animated: true)
        
        textField.inputAccessoryView = toolbar
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<DatePickerTextField>) {
        if let selectedDate = date {
            let dataFormat = DateFormatter()
            dataFormat.dateFormat = "yyyy-MM-dd"
            uiView.text = dataFormat.string(from: selectedDate)
        }
    }
    
    class Coordinator: NSObject {
        private let parent : DatePickerTextField

        init(parent: DatePickerTextField) {
            self.parent = parent
        }
        
        @objc func dateValueChanged() {
            self.parent.date = self.parent.datePicker.date
        }
        
        @objc func doneButtonTapped() {
            if self.parent.date == nil {
                self.parent.date = self.parent.datePicker.date
            }

            self.parent.textField.resignFirstResponder()
        }
    }
}
