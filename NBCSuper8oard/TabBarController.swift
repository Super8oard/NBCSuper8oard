//
//  TabBarController.swift
//  NBCSuper8oard
//
//  Created by 영현 on 1/16/24.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    var user: User?
    var boards: [Board] = []
    
    var mapTabVC: MapViewController {
        let mapTab = MapViewController()
        let mapTabItem = UITabBarItem(title: "지도", image: UIImage(named: "MapIcon")?.resized(to: CGSize(width: 20, height: 20)), tag: 0)
        mapTab.tabBarItem = mapTabItem
        return mapTab
    }
    
    var registerTab: BoardRegisterViewController {
        let registerTab = BoardRegisterViewController()
        let registerTabItem = UITabBarItem(title: "킥보드 등록", image: UIImage(named: "BoardIcon")?.resized(to: CGSize(width: 20, height: 20)), tag: 1)
        registerTab.tabBarItem = registerTabItem
        return registerTab
    }
    
    var myPageNavi: UINavigationController {
        let myPageNavi = UIStoryboard(name: "MyPage", bundle: nil).instantiateViewController(withIdentifier: "MyPageNavi") as! UINavigationController
        let myPageTab = myPageNavi.viewControllers.first as! MyPageViewController
        let myPageTabItem = UITabBarItem(title: "My Page", image: UIImage(named: "MyPageIcon")?.resized(to: CGSize(width: 20, height: 20)), tag: 2)
        myPageTab.tabBarItem = myPageTabItem
        return myPageNavi
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBar.backgroundColor = .white
        
        self.viewControllers = [mapTabVC, registerTab, myPageNavi]
    }
}

//MARK: Resize Image Object
extension UIImage {
    public func resized(to target: CGSize) -> UIImage {
        let ratio = min(
            target.height / size.height, target.width / size.width
        )
        let new = CGSize(
            width: size.width * ratio, height: size.height * ratio
        )
        let renderer = UIGraphicsImageRenderer(size: new)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: new))
        }
    }
}
