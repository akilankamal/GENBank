//
//  MockData.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import Foundation

let mockProfile = Profile(firstName: "Akilan", lastName: "Kamalakannan")

let mockTransactions = [
    Transaction(type: .debit, name: "Food", amount: 25.50, timestamp: Date().addingTimeInterval(-3600)),
    Transaction(type: .credit, name: "Salary", amount: 1500.00, timestamp: Date().addingTimeInterval(-86400)),
    Transaction(type: .debit, name: "Movie", amount: 12.00, timestamp: Date().addingTimeInterval(-7200)),
    Transaction(type: .debit, name: "Groceries", amount: 80.75, timestamp: Date().addingTimeInterval(-172800))
]

let mockAccount = Account(currentBalance: 2382.75, transactions: mockTransactions)

let mockRecipients = [
    Recipient(name: "Priya Sharma", picture: "person.circle.fill", isOnline: true),
    Recipient(name: "Rahul Verma", picture: "person.circle", isOnline: false),
    Recipient(name: "Sonia Patel", picture: "person.crop.circle.fill", isOnline: true)
]
