//
//  UserInfo.swift
//  SceneApp3
//
//  Created by Jason Samuel Lott on 12/7/22.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

public class UserInfo {
    var profPicURL: URL = URL(string: "gs://sceneapp-48eb8.appspot.com/profileImages/chooseProfilePic.jpg")!
    var user: User? = nil
    var signedInUid: String? = nil
    
    init(newProfPicURL: URL, newUser: User?, newSignedInUid: String?) {
        self.profPicURL = newProfPicURL
        self.user = newUser
        self.signedInUid = newSignedInUid
    }
    
    public func setProfPicURL(newProfPicURL: inout URL) {
        self.profPicURL = newProfPicURL
    }
    public func setUser(newUser: User?) {
        self.user = newUser
    }
    public func setSignedInUid(newSignedInUid: String?) {
        self.signedInUid = newSignedInUid
    }
    
    public func getProfPicURL() -> URL {
        return self.profPicURL
    }
    public func getUser() -> User? {
        return self.user
    }
    public func getSignedInUid() -> String? {
        return self.signedInUid
    }
    
    
    
}
