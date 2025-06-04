//
//  GENAccountService.swift
//  GENBank
//
//  Created by Akilan Kamalakannan on 04/06/25.
//

import Foundation

// Abstract of Service
protocol AnyAccountService {
    func fetchAccountDetails() async -> GENAccountDetails
}

actor GENAccountService: AnyAccountService {
    func fetchAccountDetails() async -> GENAccountDetails {
        
        // Pretends to fetch account details from a remote server
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        // Pretends to return obtained account details
        return mockAccountDetails
    }
}
