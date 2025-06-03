//
//  GENHomeViewModel.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import SwiftUI

class GENHomeViewModel: ObservableObject {
    
    @Published var accountDetails: GENAccountDetails?
    
    func fetchAccountDetails() {
        self.accountDetails = mockAccountDetails
    }
}
