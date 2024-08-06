//
//  NavigationBarRoot+Presenter.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import UIKit

protocol RootPresenter {}

protocol RootViewDelegate: ViewDelegate {}

extension NavigationBarRoot {
    class Presenter: RootPresenter {
        
        var rootView: UIViewController
        weak var view: RootViewDelegate?
        
        init(rootView: UIViewController) {
            self.rootView = rootView
        }
    }
}
