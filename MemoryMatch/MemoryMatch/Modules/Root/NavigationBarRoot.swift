//
//  NavigationBarRoot.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import UIKit

struct NavigationBarRoot {
    class View: UINavigationController, UINavigationControllerDelegate {
        
        // MARK: - Properties

        var presenter: Presenter!
        
        // MARK: - Initializers

        init(with presenter: Presenter) {
            self.presenter = presenter
            super.init(rootViewController: presenter.rootView )
            
            presenter.view = self
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Lifecycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
            delegate = self
            navigationBar.tintColor = .clear
            setNavigationBarHidden(true, animated: false)
        }
        
        // MARK: - Methods

        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            let completion = { }
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            super.pushViewController(viewController, animated: animated)
            CATransaction.commit()
            interactivePopGestureRecognizer?.isEnabled = true
        }
    }
}

extension NavigationBarRoot.View: RootViewDelegate {
    
}
