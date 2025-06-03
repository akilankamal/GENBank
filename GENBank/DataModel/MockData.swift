//
//  MockData.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import Foundation

private let mockProfile = GENProfile(firstName: "Akilan",
                             lastName: "Kamalakannan")

private let mockAccount = GENAccount(currentBalance: 2382.75,
                             transactions: mockTransactions)

private let mockRecipients = [
    GENRecipient(name: "Priya Sharma",
                 picture: "person.circle.fill",
                 isOnline: true),
    GENRecipient(name: "Rahul Verma",
                 picture: "person.circle",
                 isOnline: false),
    GENRecipient(name: "Sonia Patel",
                 picture: "person.crop.circle.fill",
                 isOnline: true)
]

private let mockTransactions: [GENTransaction] = [
    GENTransaction(type: .credit, name: "Salary", amount: 1200.00, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 19)),
    GENTransaction(type: .debit, name: "Groceries", amount: 85.50, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 18)),
    GENTransaction(type: .debit, name: "Food", amount: 32.00, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 17)),
    GENTransaction(type: .debit, name: "Movie", amount: 15.00, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 16)),
    GENTransaction(type: .credit, name: "Bonus", amount: 500.00, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 15)),
    GENTransaction(type: .debit, name: "Shopping", amount: 120.00, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 14)),
    GENTransaction(type: .debit, name: "Rent", amount: 700.00, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 13)),
    GENTransaction(type: .credit, name: "Gift", amount: 200.00, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 12)),
    GENTransaction(type: .debit, name: "Utilities", amount: 60.00, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 11)),
    GENTransaction(type: .debit, name: "Dining", amount: 45.00, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 10)),
    GENTransaction(type: .credit, name: "Salary", amount: 1200.00, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 9)),
    GENTransaction(type: .debit, name: "Groceries", amount: 90.00, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 8)),
    GENTransaction(type: .debit, name: "Food", amount: 28.00, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 7)),
    GENTransaction(type: .debit, name: "Movie", amount: 18.00, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 6)),
    GENTransaction(type: .credit, name: "Bonus", amount: 400.00, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 5)),
    GENTransaction(type: .debit, name: "Shopping", amount: 110.00, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 4)),
    GENTransaction(type: .debit, name: "Rent", amount: 700.00, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 3)),
    GENTransaction(type: .credit, name: "Gift", amount: 150.00, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 2)),
    GENTransaction(type: .debit, name: "Utilities", amount: 65.00, timestamp: Date().addingTimeInterval(-18 * 24 * 60 * 60 * 1)),
    GENTransaction(type: .debit, name: "Dining", amount: 50.00, timestamp: Date())
]

let mockAccountDetails = GENAccountDetails(profile: mockProfile,
                                           account: mockAccount,
                                           recipients: mockRecipients,
                                           transactions: mockTransactions)
