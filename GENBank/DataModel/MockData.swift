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

private let mockTransactions = [
    GENTransaction(type: .debit,
                   name: "Food",
                   amount: 25.50,
                   timestamp: Date().addingTimeInterval(-3600)),
    GENTransaction(type: .credit,
                   name: "Salary",
                   amount: 1500.00,
                   timestamp: Date().addingTimeInterval(-86400)),
    GENTransaction(type: .debit,
                   name: "Movie",
                   amount: 12.00,
                   timestamp: Date().addingTimeInterval(-7200)),
    GENTransaction(type: .debit,
                   name: "Groceries",
                   amount: 80.75,
                   timestamp: Date().addingTimeInterval(-172800))
]

let mockAccountDetails = GENAccountDetails(profile: mockProfile,
                                           account: mockAccount,
                                           recipients: mockRecipients,
                                           transactions: mockTransactions)
