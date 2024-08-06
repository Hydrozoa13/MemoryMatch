//
//  UserDefKeys.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import Foundation

final class UserDefKeys {
    static let shared = UserDefKeys()
    private init() {}
    
    let isUserOnboarded = "isUserOnboarded"
    let isUserAllowsNotifications = "isUserAllowsNotifications"
}
