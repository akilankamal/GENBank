//
//  GENHomeView.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import SwiftUI

struct GENHomeView: View {
    @StateObject private var viewModel = GENHomeViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // Welcome message as navigation title substitute
            GENWelcomeView(firstName: viewModel.accountDetails?.profile.firstName)
                .padding(.horizontal, 24)
                .padding(.top, 24)

            Divider()
                .padding(.vertical, 8)

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    GENBalanceView(formattedBalance: viewModel.accountDetails?.account.formattedBalance ?? "$0.00")
                        .padding(.horizontal, 24)
                        .padding(.bottom, 8)

                    if let txs = viewModel.accountDetails?.account.transactions {
                        GENBalanceChartView(transactions: txs)
                            .frame(height: 180)
                            .cornerRadius(12)
                            .padding(.horizontal, 24)
                            .padding(.bottom, 8)
                    }

                    if let recipients = viewModel.accountDetails?.recipients {
                        RecipientsSection(recipients: recipients)
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                    }

                    if let txs = viewModel.accountDetails?.account.transactions {
                        TransactionHistorySection(transactions: txs)
                    }
                }
                .padding(.bottom, 16)
            }
        }
        .background(Color(.systemGroupedBackground))
        .onAppear {
            viewModel.fetchAccountDetails()
        }
    }
}

#Preview {
    GENHomeView()
}
