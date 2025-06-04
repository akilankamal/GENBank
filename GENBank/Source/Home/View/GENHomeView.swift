//
//  GENHomeView.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import SwiftUI

struct GENHomeView: View {
    
    @ObservedObject var viewModel: GENHomeViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            
            GENWelcomeView(firstName: viewModel.accountDetails?.profile.firstName)
                .padding(.horizontal, 24)
                .padding(.top, 24)
            
            Divider()
                .padding(.vertical, 8)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    
                    // Display balance on all cases
                    // Display $0.00 even if balance is nil
                    GENBalanceView(formattedBalance: viewModel.accountDetails?.account.formattedBalance ?? "$0.00")
                        .padding(.horizontal, 24)
                        .padding(.bottom, 8)
                    
                    // Charts are created based on obtained transactions
                    if let txs = viewModel.accountDetails?.account.transactions {
                        GENBalanceChartView(transactions: txs)
                            .frame(height: 180)
                            .cornerRadius(12)
                            .padding(.horizontal, 24)
                            .padding(.bottom, 8)
                    }
                    
                    // Recipient list is created based on obtained recipients
                    if let recipients = viewModel.accountDetails?.recipients {
                        RecipientsSection(recipients: recipients)
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                    }
                    
                    // Transaction history is created based on obtained transactions
                    if let txs = viewModel.accountDetails?.account.transactions {
                        TransactionHistorySection(transactions: txs)
                    }
                }
                .padding(.bottom, 16)
            }
        }
        .background(Color(.systemGroupedBackground))
        
        // Fetch account details when the view appears
        .task {
            await viewModel.fetchAccountDetails()
        }
    }
}

#Preview {
    GENHomeView(viewModel: GENHomeViewModel(service: GENAccountService()))
}
