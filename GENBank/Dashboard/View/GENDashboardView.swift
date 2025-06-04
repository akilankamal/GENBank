//
//  GENDashboardView.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import SwiftUI

struct GENDashboardView: View {
    @State private var selectedTab: Tab = .home
    @StateObject private var homeViewModel = GENHomeViewModel(service: GENAccountService())

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Group {
                    switch selectedTab {
                    case .home:
                        NavigationStack {
                            GENHomeView(viewModel: homeViewModel)
                                .navigationBarHidden(true)
                        }
                    case .stats:
                        NavigationStack {
                            StatsView()
                                .navigationTitle("Stats")
                        }
                    case .profile:
                        NavigationStack {
                            ProfileView()
                                .navigationTitle("Profile")
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                Spacer(minLength: 0)
                HStack {
                    GENFloatingTabBar(selected: $selectedTab)
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
                .background(Color(.systemGroupedBackground).ignoresSafeArea(edges: .bottom))
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            
            if homeViewModel.isLoading {
                Color.black.opacity(0.2)
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            }
        }
    }
}

struct StatsView: View {
    var body: some View {
        Text("Stats Screen")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGroupedBackground))
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile Screen")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    GENDashboardView()
}
