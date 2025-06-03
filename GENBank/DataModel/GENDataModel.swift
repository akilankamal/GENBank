//
//  GENDataModel.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import Foundation

struct Profile {
    let firstName: String
    let lastName: String
}

enum TransactionType: String {
    case credit = "Credit"
    case debit = "Debit"
}

struct Transaction {
    let type: TransactionType
    let name: String
    let amount: Double
    let timestamp: Date
}

struct Account {
    let currentBalance: Double
    let transactions: [Transaction]
}

struct Recipient {
    let name: String
    let picture: String
    let isOnline: Bool
}
