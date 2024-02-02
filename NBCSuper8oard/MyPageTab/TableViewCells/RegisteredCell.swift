//
//  RegisteredCell.swift
//  NBCSuper8oard
//
//  Created by JiHoon K on 1/22/24.
//

//let boardType: String
//let boardNumber: Int
//var boardBattery: Int
//let boardPrice: Int
//var boardLocation: NMGLatLng
//var isAvailable: Bool

import UIKit

class RegisteredCell: UITableViewCell {
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var batteryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var typeValue: String? {
        didSet {
            typeLabel.text = typeValue
        }
    }
    
    var numberValue: String? {
        didSet {
            numberLabel.text = numberValue
        }
    }
    
    var batteryValue: String? {
        didSet {
            batteryLabel.text = batteryValue
        }
    }
    
    var priceValue: String? {
        didSet {
            priceLabel.text = priceValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
