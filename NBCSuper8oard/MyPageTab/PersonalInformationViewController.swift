//
//  PersonalInformationViewController.swift
//  NBCSuper8oard
//
//  Created by JiHoon K on 1/17/24.
//

import UIKit

class PersonalInformationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                           style: .plain, target: self, action: #selector(backButton(_:)))
        
    }

    @objc
    private func backButton(_ gesture: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
}
