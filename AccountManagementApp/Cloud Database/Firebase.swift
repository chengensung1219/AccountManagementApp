//
//  Firebase.swift
//  AccountManagementApp
//
//  Created by Simon Sung on 3/19/25.
//
import FirebaseAuth
import FirebaseFirestore

struct AuthService {

    func register(email: String, password: String, fullName: String, phoneNumber: String, completion: @escaping (String) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { createResult, error in
            if error != nil {
                print(error!.localizedDescription)
                completion(error!.localizedDescription)
            } else {
                print("User created.")
                completion("")
            }
            
            guard let uid = createResult?.user.uid else { return }
            
            let db = Firestore.firestore()
            db.collection("users").document(uid).setData([
                "full_name": fullName,
                "phone_number": phoneNumber
            ]) { error in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    print("Info document stored.")
                }
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (String) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { loginResult, error in
            if error != nil {
                print(error!.localizedDescription)
                completion("The email and password do not match. Please check your credentials and try again.")
            } else {
                print("User logged in.")
                completion("")
            }
            
        }
    }

    func logout(completion: @escaping (Bool) -> Void){
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch let error {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    func deleteUser(complition: @escaping (Bool) -> Void){
        
        guard let currentUser = Auth.auth().currentUser else {
            print("No user logged in.")
            return
        }
        
        let uid = currentUser.uid
        
        let db = Firestore.firestore()
        db.collection("users").document(uid).delete() { error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("User info deleted.")
            }
        }
        
        currentUser.delete { error in
            if error != nil {
                print(error!.localizedDescription)
                complition(false)
            } else {
                print("User account deleted.")
                complition(true)
            }
            
        }
    }
    func updateUser(fullName: String, phoneNumber: String) {
        
        guard let currentUser = Auth.auth().currentUser else {
            print("No user logged in.")
            return
        }
        
        let uid = currentUser.uid
        
        let db = Firestore.firestore()
        db.collection("users").document(uid).updateData([
                "full_name": fullName,
                "phone_number": phoneNumber
            ]) { error in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    print("User document successfully updated!")
                }
            }
    }
}



