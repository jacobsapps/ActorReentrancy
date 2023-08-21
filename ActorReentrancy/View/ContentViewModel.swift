//
//  ContentViewModel.swift
//  ActorReentrancy
//
//  Created by Jacob Bartlett on 21/08/2023.
//

import Foundation

@MainActor
final class ContentViewModel: ObservableObject {
    
    @Published private(set) var friends: [Friend] = []
    @Published private(set) var user: User?
    
    private let userService: UserService
    private let friendService: FriendService
    
    init(userService: UserService = UserServiceImpl(),
         friendService: FriendService = FriendServiceImpl()) {
        self.userService = userService
        self.friendService = friendService
    }
    
    func load() async {
        async let user = userService.fetchUserInfo()
        async let friends = friendService.fetchFriendInfo()
        self.user = try? await user
        self.friends = (try? await friends) ?? []
    }
}
