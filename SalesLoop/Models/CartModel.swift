import Foundation

private struct CartResponse: Codable {
    let cart: Cart
}

class CartViewModel: ObservableObject {
    @Published var cart: Cart?
    @Published var isLoading: Bool = false

    init(cartId: String) {
        fetchCart(cartId: cartId)
    }

    func loadToken() -> String {
        UserDefaults.standard.string(forKey: "userToken") ?? ""
    }

    private func fetchCart(cartId: String) {
        makeRequest(endpoint: "cart/\(cartId)?includeProduct=true", method: "GET", body: nil)
    }
    
    func refetchCart() {
        fetchCart(cartId: cart?.id ?? "")
    }

    func deleteItem(itemId: String) {
        makeRequest(endpoint: "cart/item/\(itemId)", method: "DELETE", body: nil)
    }

    func modifyQuantity(itemId: String, quantity: Int) {
        let body = ["qty": quantity]
        guard let bodyData = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
        makeRequest(endpoint: "cart/item/\(itemId)", method: "PATCH", body: bodyData)
    }

    private func makeRequest(endpoint: String, method: String, body: Data?) {
        guard let url = URL(string: "https://sales-loop.jackcrane.rocks/\(endpoint)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = method
        let token = loadToken()
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    // Handle network error or no data
                    print("Network error or no data")
                }
                return
            }

            if let jsonString = String(data: data, encoding: .utf8), method == "GET" {
                print("Received JSON string: \(jsonString)")
            }

            if method == "GET" {
                self?.processCartData(data: data)
            } else {
                // After modifying or deleting an item, refetch the cart to update the UI
                self?.fetchCart(cartId: "YourCartIDHere") // Replace "YourCartIDHere" with actual cart ID variable if available
            }
        }.resume()
    }

    private func processCartData(data: Data) {
        do {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let cartResponse = try decoder.decode(CartResponse.self, from: data)
            DispatchQueue.main.async {
                self.cart = cartResponse.cart
            }
        } catch {
            DispatchQueue.main.async {
                // Handle JSON decoding error
                print("JSON decoding error: \(error)")
            }
        }
    }
}
