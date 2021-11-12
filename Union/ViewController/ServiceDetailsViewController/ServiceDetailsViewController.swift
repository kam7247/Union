//
//  ServiceDetailsViewController.swift
//  Union
//
//  Created by Камилла Буланова on 09.11.2021.
//

import UIKit

class ServiceDetailsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    var selectedService: ServiceModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.layer.cornerRadius = 10
        setupUI()
    }
    
    private func setupUI() {
        nameLabel.text = selectedService.name
        typeLabel.text = selectedService.type
        addressLabel.text = selectedService.address
        phoneNumberLabel.text = selectedService.phoneNumber
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let vc = DatePickerViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        sheetViewController?.attemptDismiss(animated: true)
    }
}
