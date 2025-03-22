//
//  AccountManagementAppApp.swift
//  AccountManagementApp
//
//  Created by Simon Sung on 3/17/25.
//

import SwiftUI
import Firebase

@main
struct AccountManagementAppApp: App {
    @StateObject var dataManager = DataManager()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(dataManager)
        }
    }
}
