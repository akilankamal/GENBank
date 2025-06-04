//
//  GENBalanceView.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import SwiftUI

struct GENBalanceView: View {
    
    let formattedBalance: String
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(formattedBalance)
                .foregroundColor(.black)
                .font(.title)
                .fontWeight(.bold)
            Text("Balance")
                .foregroundColor(.gray)
                .font(.callout)
            Spacer()
        }
    }
}

#Preview {
    GENBalanceView(formattedBalance: "$1,234.56")
}
