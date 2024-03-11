import Foundation

// Define a struct for the User
struct User: Codable {
    let id: String
    let email: String
    let name: String
    let companyId: String
    let role: String?
    let active: Bool
    let createdAt: Date
    let updatedAt: Date
    let company: Company
    
    enum CodingKeys: String, CodingKey {
        case id, email, name, companyId, role, active, createdAt, updatedAt, company
    }
}

// Define a nested struct for the Company within the User
struct Company: Codable {
    let id: String
    let name: String
    let logoUrl: String
    let tier: String
    let onboardingStage: String
    let stripeCustomerId: String?
    let stripeSubscriptionId: String?
    let stripeSetupIntentId: String?
    let allowedAuthDomain: String?
    let inGoodPaymentStanding: Bool
    let active: Bool
    let hasCompletedOnboarding: Bool
    let createdAt: Date
    let updatedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id, name, logoUrl, tier, onboardingStage, stripeCustomerId, stripeSubscriptionId, stripeSetupIntentId, allowedAuthDomain, inGoodPaymentStanding, active, hasCompletedOnboarding, createdAt, updatedAt
    }
}

// Extension to parse ISO8601 Date format
extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}

// Custom decoder to handle the date decoding
extension JSONDecoder {
  static let iso8601withFractionalSeconds: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
    return decoder
  }()
}
