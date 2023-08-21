//
//  User.swift
//  ActorReentrancy
//
//  Created by Jacob Bartlett on 21/08/2023.
//

import Foundation

struct User: Codable {
    
    let id: String
    let name: String
    let registrationDate: Date
    
    static func sample() -> User {
        User(id: UUID().uuidString,
             name: "Jacob",
             registrationDate: Date().addingTimeInterval(-100_000))
    }
}
