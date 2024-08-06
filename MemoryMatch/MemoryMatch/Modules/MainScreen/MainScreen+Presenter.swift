//
//  MainScreen+Presenter.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import Foundation
import SafariServices

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
        
        func navigateToGameScreen() {
            view?.navigate(to: GameScreen.View.init(with: .init()))
        }
        
        func showSafariPage() {
            if let url = URL(string: "https://odd-confidence-d37.notion.site/Test-Task-Memory-match-573a43577867462da17660d1eba8f774") {
                let configuration = SFSafariViewController.Configuration()
                configuration.entersReaderIfAvailable = true

                let viewController = SFSafariViewController(url: url, configuration: configuration)
                view?.navigationController?.present(viewController, animated: true)
            }
        }
    }
}
