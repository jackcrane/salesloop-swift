//
//  ContentView.swift
//  SalesLoop
//
//  Created by Jack Crane on 3/11/24.
//

import SwiftUI

struct HomeScreen: View {
    // Use carts
    @ObservedObject var cartViewModel = CartsViewModel()
    
    var body: some View {
        NavigationView {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Common Tasks")
                            .font(.title2)
                            .padding([.leading, .trailing])
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Button(action: {}) {
                                    Image(systemName: "cart")
                                    Text("Create a new cart")
                                }
                                .tint(.teal)
                                Button(action: {}) {
                                    Image(systemName: "cart")
                                    Text("Create a new cart")
                                }
                                .tint(.blue)
                                Button(action: {}) {
                                    Image(systemName: "cart")
                                    Text("Create a new cart")
                                }
                                .tint(.purple)
                            }.padding([.leading, .trailing])
                        }.buttonStyle(.bordered)
                            .controlSize(.extraLarge)
                            .buttonBorderShape(.roundedRectangle)
                        
                    }
                    List {
                        Section(header: Text("Existing carts")) {
                            ForEach(cartViewModel.carts) { cart in
                                NavigationLink(destination: CartView(cartId: cart.id)) {
                                    VStack(alignment: .leading) {
                                        Text(cart.name)
                                        HStack {
                                            Text("Products: \(cart.products.count)")
                                            Image(systemName: "circle.fill")
                                                .foregroundStyle(.tertiary)
                                                .font(.system(size: 8))
                                            Text("Created \(dateToString(date:cart.createdAt))")
                                            Spacer()
                                        }
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                        Section(header: Text("Past Carts")) {
                            Text("Cart 1!")
                        }
                        Section(header: Text("Other")) {
                            NavigationLink(destination: AboutCartView()) {
                                Text("Archived Carts")
                            }
                            NavigationLink(destination: {}) {
                                Text("Settings")
                            }
                            
                            NavigationLink(destination: AccountScreen()) {
                                Text("Account")
                            }
                        }
                    }
                }.navigationTitle("SalesLoop")
        }
    }
}

#Preview {
    HomeScreen()
}
