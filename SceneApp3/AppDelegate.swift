//
//  AppDelegate.swift
//  SceneApp3
//
//  Created by Jason Lott on 8/17/22.
//
// Jason Token: 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

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var profilePic: UIImage?, firstName: String?, displayName: String?, type: Int?, eventNames: [String]?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        FirebaseApp.configure()
        
        let changeListener = Auth.auth().addStateDidChangeListener {
            auth, user in
            if user != nil {
                // User is signed in.
                let group = DispatchGroup()
                group.enter()
                    let db = Firestore.firestore()
                    let signedInUid = user!.uid
                    
                    // Locate the current user's account
                    let docRef = db.collection("users").document(signedInUid)
                    // Grab info from their account
                    docRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            DispatchQueue.main.async {
                                self.firstName = document.get("firstName") as? String
                                self.type = document.get("type") as? Int
                            }
                        } else {
                            print("Document does not exist")
                        }
                    }
                // get profile photo from firebase storage
                let profPhotoRef = Storage.storage().reference(forURL: user!.photoURL?.absoluteString ?? "gs://sceneapp-48eb8.appspot.com/profileImages/chooseProfilePic.png")
                profPhotoRef.getData(maxSize: 2048*2048) { data, error in
                    if let error = error {
                        print(error)
                    } else {
                        DispatchQueue.main.async {
                            self.profilePic =  UIImage(data: data!)
                            self.displayName = user?.displayName
                            group.leave()
                        }
                    }
                }
//                let task = URLSession.shared.dataTask(with: (user!.photoURL ?? URL(string: "gs://sceneapp-48eb8.appspot.com/profileImages/chooseProfilePic.jpg"))!, completionHandler: { data, _, error in
//                        guard let data = data, error == nil else {
//                            return
//                        }
//                        DispatchQueue.main.async {
//                            let image = UIImage(data: data)
//                            self.profilePic = image
//                            self.displayName = user?.displayName
//                            group.leave()
//                        }
//                    })
//                    task.resume()
//
                group.notify(queue: .main) {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "HomeVC2")
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                }
            } else {
                // No user is signed in.
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let signInController = storyboard.instantiateViewController(withIdentifier: "LoginNavigationController")
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(signInController)
            }
        }
        Auth.auth().removeStateDidChangeListener(changeListener)
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

