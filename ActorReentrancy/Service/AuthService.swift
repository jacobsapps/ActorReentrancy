//
//  AuthService.swift
//  ActorReentrancy
//
//  Created by Jacob Bartlett on 21/08/2023.
//

import Foundation

protocol AuthService: AnyActor {
    
    /// Return a valid, refreshed, bearer token.
    ///
    func getBearerToken() async throws -> String
}

actor AuthServiceImpl: AuthService {
    
    enum Strategy {
        case naive
        case ideal
    }
    
    static let shared = AuthServiceImpl()
    
    let strategy: Strategy
    var tokenTask: Task<String, Error>?
    
    private init(strategy: Strategy = .ideal) {
        self.strategy = strategy
    }
    
    func getBearerToken() async throws -> String {
        switch strategy {
        case .naive:
            return try await getBearerTokenNaively()
            
        case .ideal:
            return try await getBearerTokenIdeally()
        }
    }
    
    private func getBearerTokenNaively() async throws -> String {
        try await fetchValidAuthToken()
    }
        
    private func getBearerTokenIdeally() async throws -> String {
        if tokenTask == nil {
            tokenTask = Task { try await fetchValidAuthToken() }
        }
        
        defer { tokenTask = nil }
        
        return try await tokenTask!.value
    }
    
    // Various print statements and waits to represent the
    // work that would be done by a 'real' service
    private func fetchValidAuthToken() async throws -> String {
        print("Checking the keychain for credentials...")
        print("Credentials found!")
        print("Checking the expiry on the credentials...")
        print("Credentials expired!")
        print("Refreshing auth token...")
        try await Task.sleep(for: .seconds(1))
        print("Token refreshed!")
        print("Storing fresh token on the keychain...")
        print("Token stored!")
        return "0123456789"
    }
}
