//
//  DatePickerViewController.swift
//  Union
//
//  Created by Камилла Буланова on 10.11.2021.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupUI()
        createDatePicker()
        createTimePicker()
    }
    
    private func setupUI() {
        signUpButton.layer.cornerRadius = 10
        title = "Запись"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func createDatePicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateDonePressed))
        toolBar.setItems([doneButton], animated: true)
        
        dateTextField.inputAccessoryView = toolBar
        dateTextField.inputView = datePicker
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        let nextDays = Calendar.current.date(byAdding: .day, value: 2, to: Date())
        datePicker.maximumDate = nextDays ?? Date()
    }
    
    private func createTimePicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeDonePressed))
        toolBar.setItems([doneButton], animated: true)
        
        timeTextField.inputAccessoryView = toolBar
        timeTextField.inputView = timePicker
        
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.minimumDate = Date()
        let nextDays = Calendar.current.date(byAdding: .hour, value: 10, to: Date())
        timePicker.maximumDate = nextDays ?? Date()
    }
    
    
    @objc func dateDonePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func timeDonePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        timeTextField.text = dateFormatter.string(from: timePicker.date)
        self.view.endEditing(true)
    }

    @IBAction func signUpButtonPressed(_ sender: Any) {
        guard let dateText = dateTextField.text, !dateText.isEmpty else {
            let alert = UIAlertController(title: "Ошибка", message: "Выберите дату", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
            present(alert, animated: true)
            return
        }
        
        guard let timeText = timeTextField.text, !timeText.isEmpty else {
            let alert = UIAlertController(title: "Ошибка", message: "Выберите время", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
            present(alert, animated: true)
            return
        }
        
        let alert = UIAlertController(title: "Успешно!", message: "Вы успешно записались!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}
