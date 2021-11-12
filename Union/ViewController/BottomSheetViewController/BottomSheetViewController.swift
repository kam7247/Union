//
//  BottomSheetViewController.swift
//  Union
//
//  Created by Камилла Буланова on 08.11.2021.
//

import UIKit

protocol PresenterDelegate: AnyObject {
    func presentDetaulViewController(with service: ServiceModel)
}

class BottomSheetViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
        
    // MARK: - Properties
    private let services = LocalDataBase.services
    var delegate: PresenterDelegate!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - Setup
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let serviceNib = UINib(nibName: "ServiceTableViewCell", bundle: nil)
        tableView.register(serviceNib, forCellReuseIdentifier: "ServiceTableViewCell")
    }
}

// MARK: - TableViewDelegate
extension BottomSheetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.presentDetaulViewController(with: services[indexPath.row])
    }
}

// MARK: - TableViewDataSource
extension BottomSheetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceTableViewCell") as! ServiceTableViewCell
        cell.configureCell(with: services[indexPath.row])
        return cell
    }
}
