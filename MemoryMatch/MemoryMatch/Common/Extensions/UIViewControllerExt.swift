//
//  UIViewControllerExt.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import UIKit

public protocol ViewDelegate: AnyObject {
    var navigationController: UINavigationController? { get }
    func navigate(to nextView: UIViewController, animated: Bool)
    func pop(animated: Bool)
}

public extension ViewDelegate {
    var navigationController: UINavigationController? { nil }
    func navigate(to nextView: UIViewController) {
        self.navigate(to: nextView, animated: true)
    }
}

extension UIViewController {
    
    public func pop(animated: Bool = true) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: animated)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension UIViewController: ViewDelegate {
    
    public func navigate(to nextView: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(nextView, animated: animated)
        }
    }
    
    func setupPopUpView(vc: UIViewController) {
        self.addChild(vc)
        vc.didMove(toParent: self)
        self.view.addSubview(vc.view)
    }
    
    private func findFirstResponder() -> UITextField? {
        var firstResponder: UITextField?
        view.subviews.forEach { view in
            if let textField = view as? UITextField, view.isFirstResponder {
                firstResponder = textField
            }
        }
        return firstResponder
    }
}

