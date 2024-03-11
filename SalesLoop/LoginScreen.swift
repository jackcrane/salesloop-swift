//
//  LoginScreen.swift
//  SalesLoop
//
//  Created by Jack Crane on 3/12/24.
//

import SwiftUI

struct LoginScreen: View {
    @FocusState private var isInputActive: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isAuthenticated = false
    @ObservedObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Image(colorScheme == .dark ? "logo-cw" : "logo-cb")
                    .resizable()
                    .frame(width: 666/3, height: 155/3)
                    .aspectRatio(1, contentMode: .fit)
                    .padding([.bottom])
                
                TextField("Your work Email", text: $email)
                    .autocapitalization(.none)
                    .padding()
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))

                SecureField("Password", text: $password)
                    .autocapitalization(.none)
                    .padding()
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
                Divider()
                HStack {
                    Text("If you forget your login information or do not have an account, please contact your manager.")
                        .font(.footnote)
                    Spacer()
                    Button(action: {
                        authViewModel.login(email: email, password: password)
                    }) {
                        Text("Login")
                    }
                    .tint(.teal)
                    .buttonStyle(.bordered)
                    .controlSize(.extraLarge)
                    .buttonBorderShape(.roundedRectangle)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Login Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                
                
                    
            }
            .padding()
            .navigationTitle("Login")
            .navigationBarHidden(true)
            .background(NavigationLink(destination: HomeScreen(), isActive: $isAuthenticated) { EmptyView() })

        }
        .background(Color(.systemGroupedBackground)) // Adjust background color as needed
        .ignoresSafeArea()
    }
}

#Preview {
    LoginScreen(authViewModel: AuthViewModel())
}
