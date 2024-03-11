//
//  AboutCartView.swift
//  SalesLoop
//
//  Created by Jack Crane on 3/11/24.
//

import SwiftUI

struct AboutCartView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("The Cart Page")
                    .font(.title)
                Text("The Cart Page is your hub for everything on a certain cart. In the cart page you can view, remove, and change the quantity of items in your cart. You can also update the customer information, view logs and more information, and submit the cart to your supply chain or to an external vendor. ")
                
                Text("Editing Cart Entries")
                    .font(.title2)
                    .padding(.top, 1)
                Text("You can alter the quantity and presence of cart entries by swiping from right to left on the cart entry you wish to modify. You will be prompted with a trash can icon. Tap it to delete an entry from your cart. You will also be prompted with a \"Modify\" button that you can tap to change the quantity of a cart entry.")
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .navigationTitle("About Carts")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        HStack {
                            Image(systemName: "chevron.compact.down")
                            Text("Pull down to dismiss")
                        }
                        .foregroundStyle(.secondary)
                    }
                }
        }
    }
}

#Preview {
    AboutCartView()
}
