//
//  GENHomeView.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import SwiftUI

struct GENHomeView: View {
    @StateObject private var viewModel = GENHomeViewModel()
    @State private var selectedTab: Tab = .home

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                GENWelcomeView(firstName: viewModel.accountDetails?.profile.firstName)
                    .padding(.horizontal, 24)
                    .padding(.top, 24)

                Divider()
                    .padding(.vertical, 8)

                // Scrollable content
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
                    }
                }

                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            // Fixed bottom bar
            VStack {
                Spacer()
                HStack {
                    FloatingTabBar(selected: $selectedTab)
                        .padding(.leading, 24)
                    Spacer()
                    Button(action: {
                        // Action for +
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56)
                            .background(Color.black)
                            .clipShape(Circle())
                            .shadow(radius: 8)
                    }
                    .padding(.trailing, 24)
                }
                .padding(.bottom, 16)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            viewModel.fetchAccountDetails()
        }
    }
}

#Preview {
    GENHomeView()
}
