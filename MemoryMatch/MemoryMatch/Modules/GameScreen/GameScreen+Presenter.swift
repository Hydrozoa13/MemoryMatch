//
//  GameScreen+Presenter.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import Foundation

extension GameScreen {
    class Presenter {
        
        // MARK: - Properties
        
        weak var view: GameScreenView?
        
        // MARK: - Initializers
        
        init() { print(#function, self) }
        deinit { print(#function, self) }
        
        // MARK: - Methods
        
        // MARK: - Actions
        
        
    }
}
