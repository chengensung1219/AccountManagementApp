//
//  LoginView.swift
//  AccountManagementApp
//
//  Created by Simon Sung on 3/17/25.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var userIsLoggedIn: Bool = false
    @State private var showAlert = false
    @State private var errorMessage: String = ""
    @State private var isSecure: Bool = true
    
    private let authService = AuthService()
    
    var body: some View {
        if userIsLoggedIn {
            HomeView()
        } else {
            content
        }
    }
    
    var content: some View {
        NavigationStack {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                TextField("Email", text: $email)
                    .padding()
                    .frame(width: 320, height: 50)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                    .font(.system(size: 15))
                ZStack {
                    
                    if isSecure {
                        SecureField("Password", text: $password)
                            .padding()
                            .frame(width: 320, height: 50)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                            .font(.system(size: 15))
                    } else {
                        TextField("Password", text: $password)
                            .padding()
                            .frame(width: 320, height: 50)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                            .font(.system(size: 15))
                    }
                    Button(action: {
                        isSecure.toggle()
                    }) {
                        
                        Image(systemName: isSecure ? "eye.slash" : "eye")
                            .resizable()
                            .frame(width: 20, height: 15)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 40)
                    .foregroundColor(.gray)
                }
                
                NavigationLink("Forget password?") {
                    
                }
                .font(.system(size: 15))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.trailing, 15)
                .padding([.top, .bottom], 10)
                .foregroundColor(.blue)
                
                Button("Sign In") {
                    authService.login(email: email, password: password) { error in
                        if error == "" {
                            userIsLoggedIn = true
                        } else {
                            userIsLoggedIn = false
                            errorMessage = error
                            showAlert.toggle()
                        }
                    }
                    
                }
                .foregroundColor(.white)
                .frame(width: 310, height: 50)
                .background(Color.blue)
                .cornerRadius(25)
                .fontWeight(.bold)
                
                HStack{
                    Text("Don't have account?")
                        .font(.system(size: 15))
                    NavigationLink("Sign Up"){
                        RegisterView()
                    }
                    .font(.system(size: 15))
                    .foregroundColor(.blue)
                    
                }
                .padding(5)
                
            }
            .padding()
            .onAppear {
                if Auth.auth().currentUser != nil {
                    userIsLoggedIn = true
                } else {
                    userIsLoggedIn = false
                }
            }
            .alert("Error", isPresented: $showAlert, actions: {
                        Button("OK", role: .cancel) { }
                    }, message: {
                        Text(errorMessage)
                    })
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginView()
}
