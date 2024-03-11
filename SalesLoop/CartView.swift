//
//  CartView.swift
//  SalesLoop
//
//  Created by Jack Crane on 3/11/24.
//

import SwiftUI

struct CartView: View {
    @State var cartId: String
    
    @StateObject var cartViewModel: CartViewModel

    @State private var searchText = ""
    @State private var showAlert = false
    @State private var tempQuantity = ""
    @State private var itemIndexToModify: Int?
    @State private var showAboutView = false
    

    private var filteredCartItems: [ProductInCart] {
        let cartItems = cartViewModel.cart?.products ?? []
        if searchText.isEmpty {
            return cartItems
        } else {
            // Check if the product is not nil and then check the name for the search text
            return cartItems.filter { productInCart in
                guard let productName = productInCart.product?.name else { return false }
                return productName.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    
    init(cartId: String) {
            self._cartId = State(initialValue: cartId)
            // Initialize the cartViewModel with the given cartId
            self._cartViewModel = StateObject(wrappedValue: CartViewModel(cartId: cartId))
        }

    var body: some View {
        ZStack {
            List {
                ForEach(Array(filteredCartItems.enumerated()), id: \.element.id) { index, item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.product?.name ?? "Unknown Product")
                            Text(item.product?.barcode ?? "No Barcode")
                                .foregroundStyle(.secondary)
                                .textScale(.secondary)
                                .fontDesign(.monospaced)
                        }
                        Spacer()
                        Text("\(item.qty)")
                            .foregroundStyle(.tertiary)
                    }
                    .swipeActions {
                        Button("Modify") {
                            tempQuantity = "\(item.qty)"
                            itemIndexToModify = cartViewModel.cart?.products.firstIndex(where: {$0.id == item.id})
                            showAlert = true
                        }
                        .tint(.blue)
                        
                        Button(role: .destructive) {
//                            cartViewModel.deleteItem(item)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .alert("Modify Quantity", isPresented: $showAlert) {
                TextField("Quantity", text: $tempQuantity)
                    .keyboardType(.numberPad)
                Button("Update", action: {})
                Button("Cancel", role: .cancel) { }
            }
            .navigationTitle("Cart Items")
            .refreshable {
                cartViewModel.refetchCart()
            }
            .searchable(text: $searchText, prompt: "Search \(cartViewModel.cart?.name ?? "cart")")
            .toolbar {
                ToolbarItemGroup {
                    Button(action: {showAboutView = true}) {
                        HStack {
                            Image(systemName: "questionmark")
                            Text("Get help")
                        }
                    }
                    .sheet(isPresented: $showAboutView) {
                        AboutCartView()
                    }
                }
                ToolbarItem {
                    Button(action: {}) {
                        Text("Next")
                    }
                }
            }
            // Floating button in bottom right
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "camera")
                            .padding()
                            .background(.tint)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    CartView(cartId: "")
}
