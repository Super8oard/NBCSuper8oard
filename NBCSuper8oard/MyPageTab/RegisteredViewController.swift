//
//  RegisteredViewController.swift
//  NBCSuper8oard
//
//  Created by JiHoon K on 1/22/24.
//

import UIKit

class RegisteredViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var boards: [Board]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                           style: .plain, target: self, action: #selector(backButton(_:)))
        
        setUpTableView()
    }
}

extension RegisteredViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 
        return boards?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "registeredCell") as? RegisteredCell else { return UITableViewCell() }

        cell.typeValue = boards?[indexPath.section].boardType
        cell.numberValue = boards?[indexPath.section].boardNumber.description
        cell.batteryValue = boards?[indexPath.section].boardBattery.description
        cell.priceValue = boards?[indexPath.section].boardPrice.description
        
        return cell
    }
}

extension RegisteredViewController {
    private func setUpTableView() {
        tableView.dataSource = self
        
    }
    
    @objc
    private func backButton(_ gesture: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
}
