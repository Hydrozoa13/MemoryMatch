//
//  NotificationsScreen+Presenter.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import Foundation

extension NotificationsScreen {
    class Presenter {
        
        // MARK: - Properties
        
        weak var view: NotificationsScreenView?
        
        // MARK: - Initializers
        
        init() { print(#function, self) }
        deinit { print(#function, self) }
        
        // MARK: - Methods
        
        func savePermissionForNotifications() {
            UserDefaults.standard.setValue(true, forKey: UserDefKeys.shared.isUserAllowsNotifications)
        }
        
        // MARK: - Actions
        
        func navigateToLoadingScreen() {
            view?.navigate(to: LoadingScreen.View.init(with: .init()))
        }
    }
}
