//
//  MyPageViewController.swift
//  NBCSuper8oard
//
//  Created by JiHoon K on 1/16/24.
//

import UIKit

class CurrentlyRentingViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var modelImageView: UIImageView!
    @IBOutlet weak var modelNameLabel: UILabel!
    @IBOutlet weak var usageFeeLabel: UILabel!
    @IBOutlet weak var batteryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension CurrentlyRentingViewController {
    @IBAction private func tappedReturnButton() {
        
    }
}



//@available(iOS 17, *)
//#Preview(traits: .defaultLayout) {
//    return MyPageViewController()
//}
