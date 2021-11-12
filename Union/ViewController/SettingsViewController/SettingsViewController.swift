//
//  SettingsViewController.swift
//  Union
//
//  Created by Камилла Буланова on 08.11.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var metersTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
        saveButton.layer.cornerRadius = 10
        metersTextField.addDoneButtonOnKeyboard(with: "Готово")
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        guard let savedRadius = metersTextField.text,
            let intValue = Int(savedRadius)
            else { return }
        
        let alert = UIAlertController(title: "Успешно", message: "Новый радиус поиска мест: \(intValue)м.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
        present(alert, animated: true)
    }
}
