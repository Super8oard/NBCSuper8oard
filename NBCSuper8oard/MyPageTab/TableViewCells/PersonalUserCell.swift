//
//  PersonalUserCell.swift
//  NBCSuper8oard
//
//  Created by JiHoon K on 1/21/24.
//

import UIKit

class PersonalUserCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    var labelValue: String? {
        didSet {
            titleLabel.text = labelValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
