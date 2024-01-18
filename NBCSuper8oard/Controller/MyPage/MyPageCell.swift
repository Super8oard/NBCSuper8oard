//
//  MyPageCell.swift
//  NBCSuper8oard
//
//  Created by JiHoon K on 1/17/24.
//

import UIKit

class MyPageCell: UITableViewCell {
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cellData: CellData?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        setUpView()
    }
    
    struct CellData {
        let systemImage: String
        let title: String
    }
}

extension MyPageCell {
    private func setUpView() {
        if let cellData = cellData {
            titleImage.image = UIImage(systemName: cellData.systemImage)?.applyingSymbolConfiguration(.init(pointSize: 28))
            titleLabel.text = cellData.title
            
            switch cellData.title {
            case "개인정보":
                titleImage.tintColor = .lightGray
            case "내가 등록한 킥보드":
                titleImage.tintColor = .orange
            case "킥보드 이용 내역":
                titleImage.tintColor = .red
            default:
                return
            }
        }
    }
}
