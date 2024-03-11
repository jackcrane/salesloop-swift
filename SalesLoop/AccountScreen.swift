import SwiftUI

struct AccountScreen: View {
    @ObservedObject private var account = AccountViewModel()
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section("Your account") {
                    VStack(alignment: .leading) {
                        Text(account.user?.name ?? "")
                        Text("Your name")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    VStack(alignment: .leading) {
                        Text(account.user?.email ?? "")
                        Text("Your company email")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    VStack(alignment: .leading) {
                        // Safely unwrap the Date optional
                        if let createdAt = account.user?.createdAt {
                            Text(dateToString(date: createdAt))
                        }
                        Text("SalesLoop rep since")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                Section("Your company") {
                    VStack(alignment: .leading) {
                        Text(account.company?.name ?? "")
                        Text("Your company name")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                Section("Account") {
                    HStack {
                        Button(action: authViewModel.logout) {
                            Text("Log out")
                        }.foregroundColor(.red)
                    }
                }
            }
        }.navigationTitle("Your account")
    }
}

#Preview {
    AccountScreen()
}
