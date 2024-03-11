//
//  SalesLoopApp.swift
//  SalesLoop
//
//  Created by Jack Crane on 3/11/24.
//

import SwiftUI

@main
struct SalesLoopApp: App {
    @StateObject private var authViewModel = AuthViewModel()
        
    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticated {
                HomeScreen()
            } else {
                LoginScreen(authViewModel: authViewModel)
            }
        }
    }
}
