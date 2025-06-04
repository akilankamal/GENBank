//
//  GENHomeViewModel.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import SwiftUI

class GENHomeViewModel: ObservableObject {
    
    // Stores obtained account details
    @Published var accountDetails: GENAccountDetails?
    
    // Indicates loading state
    @Published var isLoading: Bool = false
    
    // Injected Banking service
    var service: AnyAccountService
    
    init(service: AnyAccountService) {
        self.service = service
    }
}

extension GENHomeViewModel {
    @MainActor
    func fetchAccountDetails() async {
        // Set loading state to indicate data fetching
        isLoading = true
        
        // Fetch account details from the service
        let details = await service.fetchAccountDetails()
        
        // Assign the obtained account details to the published property
        self.accountDetails = details
        
        // Reset loading state after fetching
        isLoading = false
    }
}
