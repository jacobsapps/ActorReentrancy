//
//  Friend.swift
//  ActorReentrancy
//
//  Created by Jacob Bartlett on 21/08/2023.
//

import Foundation

struct Friend {
    
    let id: String
    let name: String
    let friendsSince: Date
    
    static func sample() -> [Friend] {
        [
            Friend(id: UUID().uuidString,
                   name: "Mark",
                   friendsSince: Date().addingTimeInterval(-10_000)),
            Friend(id: UUID().uuidString,
                   name: "Steve",
                   friendsSince: Date().addingTimeInterval(-20_000)),
            Friend(id: UUID().uuidString,
                   name: "Larry",
                   friendsSince: Date().addingTimeInterval(-30_000)),
            Friend(id: UUID().uuidString,
                   name: "Jeff",
                   friendsSince: Date().addingTimeInterval(-40_000)),
            Friend(id: UUID().uuidString,
                   name: "Bill",
                   friendsSince: Date().addingTimeInterval(-50_000))
        ]
    }
}
