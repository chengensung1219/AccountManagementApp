//
//  DataManager.swift
//  AccountManagementApp
//
//  Created by Simon Sung on 3/19/25.
//

import SwiftUI
import Firebase
import FirebaseAuth

class DataManager: ObservableObject {
    
    @Published var user: User?
    
    init() {
        fetchUserData()
    }
    
    func fetchUserData(){
        guard let user = Auth.auth().currentUser else {
            print("No user is signed in.")
            return
        }
        let uid = user.uid
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { (document, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            if let document = document, document.exists {
                if let data = document.data() {
                    let fullName = data["full_name"] as? String ?? ""
                    let phoneNumber = data["phone_number"] as? String ?? ""
                    
                    self.user = User (id: uid, fullName: fullName, phoneNumber: phoneNumber)
                    
                } else {
                    print("No user data found.")
                }
            } else {
                print("User document does not exist.")
            }
        }

    }
}
