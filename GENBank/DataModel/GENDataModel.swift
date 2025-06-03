//
//  GENDataModel.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import Foundation

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

enum TransactionType: String {
    case credit = "Credit"
    case debit = "Debit"
}

struct GENTransaction {
    let type: TransactionType
    let name: String
    let amount: Double
    let timestamp: Date
}

struct GENAccount {
    let currentBalance: Double
    let transactions: [GENTransaction]
}

struct GENRecipient {
    let name: String
    let picture: String
    let isOnline: Bool
}
