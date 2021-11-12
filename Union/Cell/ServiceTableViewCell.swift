//
//  ServiceTableViewCell.swift
//  Union
//
//  Created by Камилла Буланова on 08.11.2021.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configureCell(with service: ServiceModel) {
        nameLabel.text = service.name
        typeLabel.text = service.type
        destinationLabel.text = "Расстояние: \(service.destination)м."
        iconImageView.image = UIImage(named: service.imageName)
    }
}
