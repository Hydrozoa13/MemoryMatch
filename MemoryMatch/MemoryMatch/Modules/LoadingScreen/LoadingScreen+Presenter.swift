//
//  LoadingScreen+Presenter.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import Foundation

extension LoadingScreen {
    class Presenter {
        
        // MARK: - Properties
        
        weak var view: LoadingScreenView?
        
        // MARK: - Initializers
        
        init() { print(#function, self) }
        deinit { print(#function, self) }
        
        // MARK: - Methods
        
        func navigateToMainScreen() {
            view?.animateFire()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
                guard let self else { return }
                view?.navigate(to: MainScreen.View.init(with: .init()))
            }
        }
        
        // MARK: - Actions
        
        
    }
}
