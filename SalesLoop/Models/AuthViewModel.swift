import Foundation

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false

    init() {
        loadAndVerifyToken()
    }
    
    func login(email: String, password: String) {
        guard let url = URL(string: "https://sales-loop.jackcrane.rocks/account/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: String] = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    // Here, handle the error. For example, you might want to show an alert to the user.
                    print("Login error: \(error.localizedDescription)")
                }
                return
            }
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            if let loginResponse = try? decoder.decode(LoginResponse.self, from: data),
               let token = loginResponse.token {
                DispatchQueue.main.async {
                    UserDefaults.standard.set(token, forKey: "userToken")
                    self?.isAuthenticated = true
                }
            } else if let loginResponse = try? decoder.decode(LoginResponse.self, from: data),
                      let errorMessage = loginResponse.message {
                DispatchQueue.main.async {
                    // Here, handle the case where there is an error message from the server.
                    print("Login failed: \(errorMessage)")
                }
            }
        }.resume()
    }
    
    func logout() {
        print("Logging out!")
        // Remove the stored token
        UserDefaults.standard.removeObject(forKey: "userToken")
        
        // Update authentication state
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
    
    func loadToken() -> String {
        return UserDefaults.standard.string(forKey: "userToken")!
    }
    
    private func loadAndVerifyToken() {
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            isAuthenticated = false
            return
        }
        
        verifyToken(token: token)
    }
    
    private func verifyToken(token: String) {
        guard let url = URL(string: "https://sales-loop.jackcrane.rocks/account") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 404 {
                do {
                    let responseData = try JSONDecoder().decode([String: String].self, from: data!)
                    if responseData["message"] == "User not found" {
                        DispatchQueue.main.async {
                            UserDefaults.standard.removeObject(forKey: "userToken")
                            self?.isAuthenticated = false
                            // Prompt user to sign in again.
                        }
                    }
                } catch {
                    print("Error decoding response: \(error)")
                }
                return
            }
            
            if error == nil {
                DispatchQueue.main.async {
                    self?.isAuthenticated = true
                }
            } else {
                DispatchQueue.main.async {
                    // Handle other potential errors, such as network issues.
                    self?.isAuthenticated = false
                }
            }
        }.resume()
    }
}
