//
//  TabBarController.swift
//  SceneApp3
//
//  Created by Ethan Jacob Lott on 12/7/22.
//

import UIKit

class CustomTabBarController: UITabBarController {

    let grayView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    
    let containerView0: UIView = {
        let view = UIView()
        view.backgroundColor = .init(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        return view
    }()
    
    let containerView1: UIView = {
        let view = UIView()
        view.backgroundColor = .init(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        return view
    }()
    
    let containerView2: UIView = {
        let view = UIView()
        view.backgroundColor = .init(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        return view
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.tintColor = #colorLiteral(red: 0.3479217589, green: 0.4500026107, blue: 0.7300929427, alpha: 1)
        tabBar.barTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        delegate = self
        
        grayView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        containerView0.frame = CGRect(x: view.frame.width/2 - 25, y: 650, width: 50, height: 50)
        containerView1.frame = CGRect(x: view.frame.width/2 - 100, y: 700, width: 50, height: 50)
        containerView2.frame = CGRect(x: view.frame.width/2 + 50, y: 700, width: 50, height: 50)
        
        // Instantiate view controllers
        let exploreNav = self.storyboard?.instantiateViewController(withIdentifier: "ExploreNav") as! UINavigationController
        
        let feedNav = self.storyboard?.instantiateViewController(withIdentifier: "FeedNav") as! UINavigationController
        
        let otherNav = self.storyboard?.instantiateViewController(withIdentifier: "OtherNav") as! UINavigationController
        
        let accountNav = self.storyboard?.instantiateViewController(withIdentifier: "AccountNav") as! UINavigationController
        
        let newPostVC = self.storyboard?.instantiateViewController(withIdentifier: "NewPostNav") as! UINavigationController
        
        
        // Create TabBar items
        exploreNav.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        
        accountNav.tabBarItem = UITabBarItem(title: "Account", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        
        feedNav.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "megaphone"), selectedImage: UIImage(systemName: "megaphone.fill"))
        
        otherNav.tabBarItem = UITabBarItem(title: "Other", image: UIImage(systemName: "gearshape.fill"), selectedImage: UIImage(systemName: "gearshape.fill"))
        
        newPostVC.tabBarItem = UITabBarItem(title: nil, image: nil, selectedImage: nil)
        
        
        // Assign viewControllers to tabBarController
        let viewControllers = [feedNav, exploreNav, newPostVC, otherNav, accountNav]
        self.setViewControllers(viewControllers, animated: false)
        
        
        guard let tabBar = self.tabBar as? CustomDesignTabBar else { return }
        
        tabBar.didTapButton = { [unowned self] in
            view.insertSubview(grayView, at: 1)
            view.insertSubview(containerView0, at: 2)
            view.insertSubview(containerView1, at: 2)
            view.insertSubview(containerView2, at: 2)
            // self.drawOval()
            // self.routeToCreateNewAd()
        }
    }
   /*
    private func drawOval() {
            
            let path = UIBezierPath(ovalIn: containerView.bounds)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.fillColor = UIColor.orange.cgColor
            shapeLayer.lineWidth = 3
            shapeLayer.strokeColor = UIColor.black.cgColor
            
            containerView.layer.addSublayer(shapeLayer)
    }*/
    
    func routeToCreateNewAd() {
        let createAdNavController = self.storyboard?.instantiateViewController(withIdentifier: "NewPostNav") as! UINavigationController
        createAdNavController.modalPresentationCapturesStatusBarAppearance = true
        self.present(createAdNavController, animated: true, completion: nil)
    }
    
    
}

// MARK: - UITabBarController Delegate
extension CustomTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
            return true
        }
        
        // Your middle tab bar item index.
        // In my case it's 1.
        if selectedIndex == 2 {
            return false
        }
        
        return true
    }

}
