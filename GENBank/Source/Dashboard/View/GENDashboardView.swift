//
//  GENDashboardView.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import SwiftUI

struct GENDashboardView: View {
    
    private enum TXT {
        static let statsTitle               = "Stats"
        static let profileTitle             = "Profile"
    }
    
    private enum ASSET {
        static let plusIcon                 = "plus"
    }
    
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
    private func MainContentView() -> some View {
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
                        .navigationTitle(TXT.statsTitle)
                }
            case .profile:
                NavigationStack {
                    GENProfileView()
                        .navigationTitle(TXT.profileTitle)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func FloatingBottomView() -> some View {
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
            Image(systemName: ASSET.plusIcon)
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
