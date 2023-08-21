//
//  FriendService.swift
//  ActorReentrancy
//
//  Created by Jacob Bartlett on 21/08/2023.
//

import Foundation

protocol FriendService {
    func fetchFriendInfo() async throws -> [Friend]
}

final class FriendServiceImpl: FriendService {

    let authService: AuthService
    
    init(authService: AuthService = AuthServiceImpl.shared) {
        self.authService = authService
    }
    
    func fetchFriendInfo() async throws -> [Friend] {
        print("Fetching friends...")
        _ = try await authService.getBearerTokenV2()
        let friends = Friend.sample()
        print("\(friends.count) friends found!")
        return friends
    }
}
