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
        VStack {
            Text(viewModel.accountDetails?.profile.firstName ?? "")
        }
        .onAppear {
            viewModel.fetchAccountDetails()
        }
    }
}

#Preview {
    GENHomeView()
}
