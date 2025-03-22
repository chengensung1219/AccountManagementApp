//
//  HomeView.swift
//  AccountManagementApp
//
//  Created by Simon Sung on 3/19/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var navigateToLogin = false
    @State private var showLogOutAlert = false
    @State private var showDeleteAlert = false
    @State private var editingName = false
    @State private var editingEmail = false
    @State private var editingPhoneNumber = false
    @State private var fullName: String = ""
    @State var email: String = ""
    @State private var phoneNumber: String = ""
    
    
    private let authService = AuthService()
    
    var body: some View {
        
        if navigateToLogin {
            LoginView()
        } else {
            content
        }
    }
    
    var content: some View {
        VStack{
            HStack{
                Spacer()
                Button("Log Out"){
                    authService.logout() { success in
                        if success {
                            navigateToLogin = true
                        }
                    }
                }
            }
            .padding(.trailing, 30)
            .bold()
            .padding(.top, 10)
            Spacer()
            if let user = dataManager.user{
                
                HStack{
                    if editingName {
                        TextField("Full Name", text: $fullName)
                            .frame(width: 150, height: 30)
                        
                        Button("Save"){
                            editingName = false
                            dataManager.user?.fullName = fullName
                            authService.updateUser(fullName: fullName, phoneNumber: user.phoneNumber)
                        }
                        Button("Cancel"){
                            editingName = false
                        }
                    } else {
                        Text(user.fullName)
                            .font(.title)
                            .bold()
                        Button("Edit"){
                            editingName = true
                        }
                        
                    }
                }

                HStack{
                    if editingPhoneNumber {
                        TextField("Phone", text: $phoneNumber)
                            .frame(width: 150, height: 30)
                        Button("Save"){
                            editingPhoneNumber = false
                            dataManager.user?.phoneNumber = phoneNumber
                            authService.updateUser(fullName: user.fullName, phoneNumber: phoneNumber)
                        }
                        Button("Cancel"){
                            editingPhoneNumber = false
                        }
                    } else {
                        Text("Phone: \(user.phoneNumber)")
                            .font(.title3)
                            .foregroundColor(.gray)
                        Button("Edit"){
                            editingPhoneNumber = true
                        }
                    }
                }
                
            } else {
                ProgressView()
                    .onAppear {
                        dataManager.fetchUserData()
                    }
            }
            Button("Delete Account"){
                showDeleteAlert = true
            }
            .foregroundColor(.red)
            .frame(width: 150, height: 35)
            .background(Color.red.opacity(0.5))
            .cornerRadius(25)
            .fontWeight(.bold)
            .padding(.top, 25)
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $showLogOutAlert) {
            Alert(
                title: Text("Are you sure?"),
                message: Text("Your account will need to login again."),
                primaryButton: .destructive(Text("Confirm")) {
                    authService.logout() { success in
                        if success {
                            navigateToLogin = true
                        } else {
                            navigateToLogin = false
                        }
                    }
                },
                secondaryButton: .cancel {
                    print("User canceled")
                }
            )
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Are you sure?"),
                message: Text("Your account will be deleted permanently."),
                primaryButton: .destructive(Text("Confirm")) {
                    authService.deleteUser() { success in
                        if success {
                            navigateToLogin = true
                        } else {
                            navigateToLogin = false
                        }
                    }
                },
                secondaryButton: .cancel {
                    print("User canceled")
                }
            )
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(DataManager())
}
