import Foundation

struct AccountResponse: Codable {
    let user: User?
    let token: String?
    let message: String?
}

class AccountViewModel: ObservableObject {
    @Published var user: User?
    @Published var isAuthenticated = false
    @Published var company: Company?


    init() {
        fetchAccountInformation()
    }
    
    func loadToken() -> String {
        UserDefaults.standard.string(forKey: "userToken") ?? ""
    }

    private func fetchAccountInformation() {
        guard let url = URL(string: "https://sales-loop.jackcrane.rocks/account") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let token = loadToken()
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    // Here, handle the network error or no data situation. For example, show an alert to the user.
                    print("Network error or no data")
                }
                return
            }
            
            // Log the raw data to the console for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON string: \(jsonString)")
            }
                        
            do {
                let accountResponse = try JSONDecoder.iso8601withFractionalSeconds.decode(AccountResponse.self, from: data)
                DispatchQueue.main.async {
                    // Check if there's a message and print it, regardless of success or error
                    if let message = accountResponse.message {
                        print("API Response Message: \(message)")
                    }
                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                        self?.user = accountResponse.user
                        self?.company = accountResponse.user?.company
                        self?.isAuthenticated = true
                    } else {
                        // Handle non-200 HTTP responses
                        self?.isAuthenticated = false
                    }
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
