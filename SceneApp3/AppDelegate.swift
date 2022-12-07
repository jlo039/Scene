//
//  AppDelegate.swift
//  SceneApp3
//
//  Created by Jason Lott on 8/17/22.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var userInfo: UserInfo = UserInfo(newProfPicURL: URL(string: "gs://sceneapp-48eb8.appspot.com/profileImages/chooseProfilePic.jpg")!, newUser: nil, newSignedInUid: nil)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        Auth.auth().addStateDidChangeListener {
            auth, user in
            if user != nil {
                // User is signed in.
                self.userInfo.profPicURL = user!.photoURL ?? self.userInfo.profPicURL
                self.userInfo.user = user
                self.userInfo.signedInUid = user!.uid
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "HomeVC")
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            } else {
                // No user is signed in.
            }
        }
        return true
    }


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

