//
//  GENWelcomeView.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import SwiftUI

struct GENWelcomeView: View {
    let firstName: String?

    var body: some View {
        HStack {
            if let firstName, !firstName.isEmpty {
                HStack(spacing: 0) {
                    Text("Welcome, ")
                        .foregroundColor(.gray)
                        .font(.largeTitle)
                    Text(firstName + "!")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                }
            } else {
                Text("Welcome")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            Spacer()
            ZStack(alignment: .topTrailing) {
                Button(action: {
                    // Bell action
                }) {
                    Image(systemName: "bell")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(.black)
                }
                Circle()
                    .fill(Color.red)
                    .frame(width: 12, height: 12)
                    .offset(x: 8, y: -6)
            }
        }
    }
}

#Preview {
    GENWelcomeView(firstName: "Test")
}
