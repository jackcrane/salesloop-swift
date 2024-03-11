//
//  ContentView.swift
//  SalesLoop
//
//  Created by Jack Crane on 3/11/24.
//

import SwiftUI

struct ContentView: View {
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
                        Section(header: Text("Carts requiring attention")) {
                            Text("Hello World")
                        }
                        Section(header: Text("Existing carts")) {
                            Text("Hullo World")
                        }
                        Section(header: Text("Past Carts")) {
                            Text("Cart 1!")
                        }
                        Section(header: Text("Other")) {
                            NavigationLink(destination: {}) {
                                Text("Archived Carts")
                            }
                            NavigationLink(destination: {}) {
                                Text("Settings")
                            }
                        }
                    }
                }.navigationTitle("SalesLoop")
        }
    }
}

#Preview {
    ContentView()
}
