//
//  GENDashboardView.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import SwiftUI

struct GENDashboardView: View {
    
    // Home selected by default
    @State private var selectedTab: Tab = .home
    
    // ViewModel for home view injected with account service
    @StateObject private var homeViewModel = GENHomeViewModel(service: GENAccountService())
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                // Main content view based on selected tab
                MainContentView()
                
                // Floating bottom view with tab bar and add button
                FloatingBottomView()
            }
            
            if homeViewModel.isLoading {
                
                // Background for loading state
                Color.black.opacity(0.2)
                    .ignoresSafeArea()
                
                // Circular progress view
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            }
        }
    }
}
    
extension GENDashboardView {
    fileprivate func MainContentView() -> some View {
        return Group {
            switch selectedTab {
            case .home:
                NavigationStack {
                    GENHomeView(viewModel: homeViewModel)
                        .navigationBarHidden(true)
                }
            case .stats:
                NavigationStack {
                    GENStatsView()
                        .navigationTitle("Stats")
                }
            case .profile:
                NavigationStack {
                    GENProfileView()
                        .navigationTitle("Profile")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    fileprivate func FloatingBottomView() -> some View {
        return HStack {
            
            // Floating tab bar
            GENFloatingTabBar(selected: $selectedTab)
                .padding(.leading, 24)
            
            Spacer()
            
            // Floating plus button
            FloatingPlusButton()
                .padding(.trailing, 24)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea(edges: .bottom))
    }
    
    fileprivate func FloatingPlusButton() -> Button<some View> {
        return Button(action: {
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
    }
}

#Preview {
    GENDashboardView()
}
