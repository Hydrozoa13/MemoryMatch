//
//  MainScreen+Presenter.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import Foundation

extension MainScreen {
    class Presenter {
        
        // MARK: - Properties
        
        weak var view: MainScreenView?
        
        // MARK: - Initializers
        
        public init() {
            print(#function, self)
        }
        
        deinit {
            print(#function, self)
        }
        
        // MARK: - Methods
        
        // MARK: - Actions
        
        
    }
}
