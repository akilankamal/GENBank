//
//  GENWelcomeView.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import SwiftUI

struct GENWelcomeView: View {
    
    private enum TXT {
        static let welcome                  = "Welcome"
    }
    
    private enum ASSET {
        static let bellIcon                 = "bell"
    }
    
    let firstName: String?
    
    var body: some View {
        HStack {
            if let firstName, !firstName.isEmpty {
                HStack(spacing: 0) {
                    Text("\(TXT.welcome), ")
                        .foregroundColor(.gray)
                        .font(.largeTitle)
                    Text(firstName + "!")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                }
            } else {
                Text(TXT.welcome)
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            Spacer()
            NotificationsButton()
        }
    }
}

extension GENWelcomeView {
    private func NotificationsButton() -> some View {
        return ZStack(alignment: .topTrailing) {
            Button(action: {
                // Button action
            }) {
                Image(systemName: ASSET.bellIcon)
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(.black)
            }
            Circle()
                .fill(Color.red)
                .frame(width: 12, height: 12)
        }
    }
}

#Preview {
    GENWelcomeView(firstName: "Test")
}
