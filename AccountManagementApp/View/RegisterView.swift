//
//  RegisterView.swift
//  AccountManagementApp
//
//  Created by Simon Sung on 3/19/25.
//

import SwiftUI

struct RegisterView: View {
    @State private var fullName: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSecure: Bool = true
    @State private var userIsSignUp: Bool = false
    @State private var showAlert = false
    @State private var errorMessage: String = ""
    
    private let authService = AuthService()
    
    
    var body: some View {
        if userIsSignUp {
            HomeView()
        } else {
            content
        }
        
    }
    
    var content: some View {
        VStack {
            Text("Register")
                .font(.largeTitle)
                .fontWeight(.bold)
            TextField("Full Name", text: $fullName)
                .padding()
                .frame(width: 320, height: 50)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(15)
                .padding(5)
                .font(.system(size: 15))
            TextField("Phone Number", text: $phoneNumber)
                .keyboardType(.phonePad)
                .padding()
                .frame(width: 320, height: 50)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(15)
                .padding(5)
                .font(.system(size: 15))
            TextField("Email", text: $email)
                .padding()
                .frame(width: 320, height: 50)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(15)
                .padding(5)
                .font(.system(size: 15))
            ZStack{
                if isSecure {
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 320, height: 50)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)
                        .padding(5)
                        .font(.system(size: 15))
                } else {
                    TextField("Password", text: $password)
                        .padding()
                        .frame(width: 320, height: 50)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(15)
                        .padding(5)
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
            
            Button("Sign Up") {
                authService.register(email: email, password: password, fullName: fullName, phoneNumber: phoneNumber) { error in
                    if error == "" {
                        userIsSignUp = true
                        
                    } else {
                        userIsSignUp = false
                        errorMessage = error
                        showAlert = true
                    }
                    
                }
            }
            .foregroundColor(.white)
            .frame(width: 310, height: 50)
            .background(Color.red.opacity(0.9))
            .cornerRadius(25)
            .fontWeight(.bold)
            .padding(.top, 25)
            
        }
        .padding()
        .alert("Error", isPresented: $showAlert, actions: {
                    Button("OK", role: .cancel) { }
                }, message: {
                    Text(errorMessage)
                })
    }
}

#Preview {
    RegisterView()
}
