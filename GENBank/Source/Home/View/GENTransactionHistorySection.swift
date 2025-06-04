//
//  GENTransactionHistorySection.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import SwiftUI

struct TransactionHistorySection: View {
    
    private enum TXT {
        static let transactionHistory       = "Transactions history"
    }
    
    private enum ASSET {
        static let downArrow                = "chevron.down"
    }
    
    private enum TransactionFilter: String, CaseIterable, Identifiable {
        case today = "Today"
        case lastWeek = "Last week"
        case lastMonth = "Last month"
        case lastYear = "Last year"
        
        var id: String { rawValue }
    }
    
    // Transactions to display, obtained from account details
    let transactions: [GENTransaction]
    
    // Selected filter state
    @State private var selectedFilter: TransactionFilter = .today
    
    var filteredTransactions: [GENTransaction] {
        let now = Date()
        let calendar = Calendar.current
        switch selectedFilter {
        case .today:
            return transactions.filter { calendar.isDateInToday($0.timestamp) }
        case .lastWeek:
            if let weekAgo = calendar.date(byAdding: .day, value: -7, to: now) {
                return transactions.filter { $0.timestamp >= weekAgo }
            }
        case .lastMonth:
            if let monthAgo = calendar.date(byAdding: .day, value: -30, to: now) {
                return transactions.filter { $0.timestamp >= monthAgo }
            }
        case .lastYear:
            if let yearAgo = calendar.date(byAdding: .day, value: -365, to: now) {
                return transactions.filter { $0.timestamp >= yearAgo }
            }
        }
        return transactions
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                
                // Section title
                Text(TXT.transactionHistory)
                    .font(.headline)
                
                Spacer()
                
                // Filter menu
                Menu {
                    ForEach(TransactionFilter.allCases) { filter in
                        Button(action: { selectedFilter = filter }) {
                            Text(filter.rawValue)
                        }
                    }
                } label: {
                    HStack(spacing: 4) {
                        Text(selectedFilter.rawValue)
                            .foregroundColor(.gray)
                        Image(systemName: ASSET.downArrow)
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .medium))
                    }
                }
            }
            .padding(.bottom, 4)
            
            ForEach(filteredTransactions) { tx in
                TransactionRow(transaction: tx)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
    }
}

struct TransactionRow: View {
    
    private enum TXT {
        static let deposit                  = "Deposit"
        static let payment                  = "Payment"
    }
    
    let transaction: GENTransaction
    
    var iconName: String {
        switch transaction.name.lowercased() {
        case "food", "dining", "ice cream": return "takeoutbag.and.cup.and.straw"
        case "salary", "bonus", "gift": return "dollarsign.circle"
        case "shopping": return "bag"
        case "rent": return "house"
        case "utilities": return "bolt"
        case "groceries": return "cart"
        case "movie": return "film"
        default: return "arrow.left.arrow.right"
        }
    }
    
    var typeLabel: String {
        transaction.type == .credit ? TXT.deposit : TXT.payment
    }
    
    var amountText: String {
        let sign = transaction.type == .credit ? "+" : "-"
        return "\(sign)$\(String(format: "%.2f", transaction.amount))"
    }
    
    var amountColor: Color {
        transaction.type == .credit ? .black : .gray
    }
    
    var body: some View {
        HStack(spacing: 16) {
            
            // Display icon
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.black.opacity(0.85))
                    .frame(width: 44, height: 44)
                Image(systemName: iconName)
                    .font(.system(size: 22))
                    .foregroundColor(.white)
            }
            
            // Display transaction name and type
            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text(typeLabel)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Display amount
            Text(amountText)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(amountColor)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    TransactionHistorySection(transactions: mockAccountDetails.transactions)
}
