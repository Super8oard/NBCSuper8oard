//
//  MyPageViewController.swift
//  NBCSuper8oard
//
//  Created by JiHoon K on 1/17/24.
//

import UIKit

class MyPageViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
      
    let cellDatas: [MyPageCell.CellData] = [.init(systemImage: "person.crop.square.fill", title: "개인정보"),
                                            .init(systemImage: "scooter", title: "내가 등록한 킥보드"),
                                            .init(systemImage: "list.bullet", title: "킥보드 이용 내역")]
    weak var tabBarVC: TabBarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarVC = parent?.parent as? TabBarController
        
        userNameLabel.text = tabBarVC?.user?.name
        setUpTableView()
    }
}

extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myPageCell") as? MyPageCell else { return UITableViewCell() }
        cell.cellData = cellDatas[indexPath.row]
        return cell
    }
}

extension MyPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch cellDatas[indexPath.row].title {
        case "개인정보":
            if let vc = storyboard?.instantiateViewController(withIdentifier: "PersonalInformationViewController") as?
                PersonalInformationViewController {
                vc.title = cellDatas[indexPath.row].title
                navigationController?.pushViewController(vc, animated: true)
            }
        case "내가 등록한 킥보드":
            if let vc = storyboard?.instantiateViewController(identifier: "PersonalInformationViewController") as? PersonalInformationViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        case "킥보드 이용 내역":
            if let vc = storyboard?.instantiateViewController(identifier: "PersonalInformationViewController") as? PersonalInformationViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        default:
            return
        }
    }
}

//MARK: - Helpers
extension MyPageViewController {
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}
