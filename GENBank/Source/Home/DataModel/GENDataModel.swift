//
//  GENDataModel.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import Foundation

// Model obtained by Service
struct GENAccountDetails {
    let profile: GENProfile
    let account: GENAccount
    let recipients: [GENRecipient]
    let transactions: [GENTransaction]
}

struct GENProfile {
    let firstName: String
    let lastName: String
}

enum GENTransactionType: String {
    case credit
    case debit
}

struct GENTransaction: Identifiable {
    let id = UUID()
    let type: GENTransactionType
    let name: String
    let amount: Double
    let timestamp: Date
}

struct GENAccount {
    let currentBalance: Double
    let transactions: [GENTransaction]
}

struct GENRecipient: Identifiable {
    let id = UUID()
    let name: String
    let picture: String
    let isOnline: Bool
}

extension GENAccount {
    var formattedBalance: String {
        String(format: "$ %.2f", currentBalance)
    }
}
