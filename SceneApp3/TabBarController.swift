//
//  TabBarController.swift
//  SceneApp3
//
//  Created by Ethan Jacob Lott on 12/7/22.
//

import UIKit

class CustomTabBarController: UITabBarController {

    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.tintColor = #colorLiteral(red: 0.3479217589, green: 0.4500026107, blue: 0.7300929427, alpha: 1)
        
        delegate = self
        
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
            self.routeToCreateNewAd()
        }
    }
    
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
        if selectedIndex == 1 {
            return false
        }
        
        return true
    }

}
