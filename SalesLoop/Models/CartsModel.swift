import Foundation

// Define your structures according to the JSON response
private struct CartResponse: Codable {
    let carts: [Cart]
}

// Define your view model
class CartsViewModel: ObservableObject {
    @Published var carts: [Cart] = []
    
    init() {
        fetchCarts()
    }
    
    func loadToken() -> String {
        UserDefaults.standard.string(forKey: "userToken") ?? ""
    }

    private func fetchCarts() {
        guard let url = URL(string: "https://sales-loop.jackcrane.rocks/cart") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let token = loadToken()
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    // Handle network error or no data
                    print("Network error or no data")
                }
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON string: \(jsonString)")
            }
                        
            do {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let cartResponse = try decoder.decode(CartResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.carts = cartResponse.carts
                }
            } catch {
                DispatchQueue.main.async {
                    // Handle JSON decoding error
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }
}
