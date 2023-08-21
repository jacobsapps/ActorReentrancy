//
//  UserService.swift
//  ActorReentrancy
//
//  Created by Jacob Bartlett on 21/08/2023.
//

import Foundation

protocol UserService {
    func fetchUserInfo() async throws -> User
}

final class UserServiceImpl: UserService {

    let authService: AuthService
    
    init(authService: AuthService = AuthServiceImpl.shared) {
        self.authService = authService
    }
    
    func fetchUserInfo() async throws -> User {
        print("Fetching user info...")
        _ = try await authService.getBearerTokenV2()
        let user = User.sample()
        print("User \(user.name) found!")
        return user
    }
}
