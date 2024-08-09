//
//  LoadingScreen+View.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import UIKit

extension LoadingScreen {
    class View: UIViewController {
        
        // MARK: - Properties
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        
        // MARK: - Subviews
        
        private let background = UIImageView(image: .background)
        private let money = UIImageView(image: .money)
        private let stars = UIImageView(image: .stars)
        private let fire = UIImageView(image: .fire)
        private let grapes = UIImageView(image: .grapes)
        private let cherries = UIImageView(image: .cherries)
        private let lemon = UIImageView(image: .lemon)
        private let orange = UIImageView(image: .orange)
        private let loadingLabel = UILabel()
        
        // MARK: - Initializers
        
        init(with presenter: Presenter) {
            self.presenter = presenter
            super.init(nibName: nil, bundle: nil)
            
            presenter.view = self
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Lifecycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setup()
            presenter.navigateToMainScreen()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            animateViews()
        }
        
        // MARK: - Private functions
        
        private func animateViews() {
            
            UIView.animate(withDuration: 1.8) {[weak self] in
                guard let self else { return }
                cherries.bounds.size.width *= 5
                cherries.bounds.size.height *= 5
                cherries.isHidden = false
            }
            
            UIView.animate(withDuration: 0.5) {[weak self] in
                guard let self else { return }
                grapes.center.x -= grapes.frame.width
                grapes.center.y -= grapes.frame.height
                grapes.isHidden = false
            }
            
            UIView.animate(withDuration: 0.8) {[weak self] in
                guard let self else { return }
                lemon.center.x += lemon.frame.width
                lemon.center.y += lemon.frame.height
                lemon.bounds.size.width *= 0.5
                lemon.bounds.size.height *= 0.5
                lemon.isHidden = false
            }
            
            UIView.animate(withDuration: 1.2) {[weak self] in
                guard let self else { return }
                orange.bounds.size.width *= 2
                orange.bounds.size.height *= 2
                orange.isHidden = false
            }
            
            UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut) { [weak self] in
                guard let self else { return }
                stars.center.y += stars.frame.height
                stars.isHidden = false
            } completion: { _ in
                SoundManager.playSound(type: .coins)
            }
            
            UIView.animate(withDuration: 1, delay: 1) { [weak self] in
                guard let self else { return }
                money.center.y -= money.frame.height
                money.isHidden = false
            }
        }
        
        // MARK: - Methods
        
        private func setup() {
            buildHierarchy()
            configureSubviews()
            layoutSubviews()
        }
        
        private func buildHierarchy() {
            view.addView(background)
            background.addView(stars)
            background.addView(grapes)
            background.addView(fire)
            background.addView(cherries)
            background.addView(lemon)
            background.addView(money)
            background.addView(orange)
            background.addView(loadingLabel)
        }
        
        private func configureSubviews() {
            loadingLabel.text = "Loading..."
            loadingLabel.font = UIFont(name: "muller", size: 57.51)
            loadingLabel.textColor = .white
            
            money.center.y += money.frame.height
            money.isHidden = true
            
            stars.center.y -= stars.frame.height
            stars.isHidden = true
            
            cherries.isHidden = true
            
            grapes.center.x += grapes.frame.width
            grapes.center.y += grapes.frame.height
            grapes.isHidden = true
            
            lemon.center.x -= lemon.frame.width
            lemon.center.y -= lemon.frame.height
            lemon.isHidden = true
            
            orange.isHidden = true
        }
        
        private func layoutSubviews() {
            NSLayoutConstraint.activate([
                background.topAnchor.constraint(equalTo: view.topAnchor),
                background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                money.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
                money.leadingAnchor.constraint(equalTo: background.leadingAnchor),
                money.trailingAnchor.constraint(equalTo: background.trailingAnchor),
                money.bottomAnchor.constraint(equalTo: background.bottomAnchor),
                
                stars.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.85),
                stars.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -53),
                stars.leadingAnchor.constraint(equalTo: background.leadingAnchor),
                stars.trailingAnchor.constraint(equalTo: background.trailingAnchor),
                
                fire.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
                fire.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
                fire.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
                fire.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: 5),
                
                grapes.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.09),
                grapes.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
                grapes.centerYAnchor.constraint(equalTo: fire.centerYAnchor, constant: -40),
                grapes.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 75),
                
                cherries.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.28),
                cherries.heightAnchor.constraint(equalTo: cherries.widthAnchor, multiplier: 1.4),
                cherries.trailingAnchor.constraint(equalTo: background.trailingAnchor),
                cherries.bottomAnchor.constraint(equalTo: money.topAnchor, constant: 5),
                
                lemon.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.12),
                lemon.heightAnchor.constraint(equalTo: lemon.widthAnchor, multiplier: 1.125),
                lemon.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 25),
                lemon.bottomAnchor.constraint(equalTo: money.topAnchor, constant: 50),
                
                orange.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.23),
                orange.heightAnchor.constraint(equalTo: orange.widthAnchor, multiplier: 0.93),
                orange.centerYAnchor.constraint(equalTo: money.centerYAnchor, constant: 22),
                orange.trailingAnchor.constraint(equalTo: background.trailingAnchor),
                
                loadingLabel.centerXAnchor.constraint(equalTo: background.centerXAnchor),
                loadingLabel.centerYAnchor.constraint(equalTo: background.centerYAnchor, constant: -10)
            ])
        }
    }
}


// MARK: - Extension View

extension LoadingScreen.View: LoadingScreenView {
    
    func animateFire() {
        let distance: CGFloat = 40
        let startYPos = fire.center.y
        
        UIView.animate(withDuration: 1, animations: { [weak self] in
            guard let self else { return }
            self.fire.center.y = startYPos - distance
            
        }) { [weak self] _ in
            guard let self else { return }
            UIView.animate(withDuration: 1, animations: {
                self.fire.center.y += distance
            }) { _ in
                self.animateFire()
            }
        }
    }
}
