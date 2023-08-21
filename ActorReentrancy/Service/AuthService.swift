//
//  AuthService.swift
//  ActorReentrancy
//
//  Created by Jacob Bartlett on 21/08/2023.
//

import Foundation

protocol AuthService: AnyActor {
    
    /// Return a valid, refreshed, bearer token
    ///
    /// This method makes no guarantees about re-entrancy and hence
    /// allows the authentication API to be called concurrently.
    ///
    func getBearerTokenV1() async throws -> String
    
    /// Return a valid, refreshed, bearer token.
    ///
    /// This version of the method ensures proper re-entrancy and avoids
    /// simultaneous calls to the authentication API.
    ///
    func getBearerTokenV2() async throws -> String
}

actor AuthServiceImpl: AuthService {
    
    static let shared = AuthServiceImpl()
    
    var tokenTask: Task<String, Error>?
    
    private init() { }
    
    func getBearerTokenV1() async throws -> String {
        try await refreshAuthToken()
    }
        
    func getBearerTokenV2() async throws -> String {
        
        if tokenTask == nil {
            tokenTask = Task { try await refreshAuthToken() }
        }
        
        defer { tokenTask = nil }
        
        return try await tokenTask!.value
    }
    
    private func refreshAuthToken() async throws -> String {
        print("Refreshing auth token...")
        try await Task.sleep(nanoseconds: 1_000_000_000)
        print("Token refreshed!")
        return "0123456789"
    }
}
