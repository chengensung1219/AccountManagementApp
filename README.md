# Overview

Recently I am planning to create an social media app. But I never play around with cloud database. Therefore, I did this simple project to help me gain basic knowledge about cloud database.

This account manager app allow you to create a account, login, managing, and delete your personal info.

The purpose to write this app is to help me developing some basic knowledge about cloud database, so I can build a big project in the future.


[Account Manager App with Firebase Demo (Cloud Database)](https://youtu.be/Na-RJ6lrics)

# Cloud Database

The cloud database that I used is Firebase.

In the Firestore database, there is a collection called `users`. Each document in this collection represents a user, identified by their unique user ID (`UID`), such as `xXd275jfsdavSdsCX`. 

For example, the document with the ID `xXd275jfsdavSdsCX` contains the following fields:
- `full_name`: `"Test Person"`,
- `phone_number`: `"1231231234"`.

# Development Environment

The tool that I used is Xcode which is a mobile app environment that using SwiftUI to let you create a iOS app. I might also use YouTube to help me get some help for it. I also used ChatGPT to help me answer some question that I don't understand.

The programing language that I used is SwiftUI and connected the application to the firebase authentication and firebase firestore database.

# Useful Websites

- [Developer documentation for Firebase](https://firebase.google.com/docs)
- [Getting started with Firebase on Apple platforms](https://www.youtube.com/watch?v=F9Gs_pfT3hs&t=62s)

# Future Work

- Email verification 
- Forget password (reset password)
- Different login methods (Apple or Google)
