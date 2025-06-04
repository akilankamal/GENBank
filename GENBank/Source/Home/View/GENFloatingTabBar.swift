//
//  GENFloatingTabBar.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//


import SwiftUI

enum Tab: String, CaseIterable {
    case home = "Home"
    case stats = "Stats"
    case profile = "Profile"
    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .stats: return "chart.bar.fill"
        case .profile: return "person.crop.circle.fill"
        }
    }
}

struct GENFloatingTabBar: View {
    
    @Binding var selected: Tab
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(Tab.allCases, id: \.self) { tab in
                TabBarButton(tab)
                    .animation(.spring(), value: selected)
            }
        }
        .padding(12)
        .background(Color.black.opacity(0.95))
        .clipShape(Capsule())
        .shadow(radius: 8)
    }
}

extension GENFloatingTabBar {
    private func TabBarButton(_ tab: Tab) -> some View {
        return Button(action: { selected = tab }) {
            HStack {
                Image(systemName: tab.icon)
                    .foregroundColor(selected == tab ? .black : .white)
                
                // Show text only when the tab is selected
                if selected == tab {
                    Text(tab.rawValue)
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                        .transition(.opacity.combined(with: .move(edge: .trailing)))
                }
            }
            .padding(.horizontal, selected == tab ? 16 : 0)
            .padding(.vertical, 10)
            .background(selected == tab ? Color.white : Color.clear)
            .clipShape(Capsule())
        }
    }
}

#Preview {
    GENFloatingTabBar(selected: .constant(.home))
}
