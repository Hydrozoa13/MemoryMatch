//
//  MainScreen+View.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import UIKit

extension MainScreen {
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
        private let menuIcon = UIImageView(image: .menuIcon)
        private let playNowBtn = UIButton()
        private let privacyPolicyBtn = UIButton()
        
        // MARK: - Initializers
        
        public init(with presenter: Presenter) {
            self.presenter = presenter
            super.init(nibName: nil, bundle: nil)
            
            presenter.view = self
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        deinit { }
        
        // MARK: - Lifecycle
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            setup()
        }
        
        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }
        
        // MARK: - Methods
        
        private func setup() {
            buildHierarchy()
            configureSubviews()
            layoutSubviews()
            setupActions()
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
            background.addView(menuIcon)
            background.addView(playNowBtn)
            background.addView(privacyPolicyBtn)
        }
        
        private func configureSubviews() {
            background.isUserInteractionEnabled = true
            
            playNowBtn.setImage(.playNowBtn, for: .normal)
            privacyPolicyBtn.setImage(.privacyPolicyBtn, for: .normal)
        }
        
        private func setupActions() {
            playNowBtn.addAction(UIAction(handler: { [weak self] _ in
                guard let self else { return }
                presenter.navigateToGameScreen()
            }), for: .touchUpInside)
            
            privacyPolicyBtn.addAction(UIAction(handler: { [weak self] _ in
                guard let self else { return }
                presenter.showSafariPage()
            }), for: .touchUpInside)
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
                
                menuIcon.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.88),
                menuIcon.heightAnchor.constraint(equalTo: menuIcon.widthAnchor, multiplier: 0.9),
                menuIcon.bottomAnchor.constraint(equalTo: background.centerYAnchor, constant: 65),
                menuIcon.centerXAnchor.constraint(equalTo: background.centerXAnchor),
                
                playNowBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.58),
                playNowBtn.heightAnchor.constraint(equalTo: playNowBtn.widthAnchor, multiplier: 0.24),
                playNowBtn.topAnchor.constraint(equalTo: menuIcon.bottomAnchor, constant: -7),
                playNowBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                privacyPolicyBtn.widthAnchor.constraint(equalTo: playNowBtn.widthAnchor),
                privacyPolicyBtn.heightAnchor.constraint(equalTo: playNowBtn.heightAnchor),
                privacyPolicyBtn.topAnchor.constraint(equalTo: playNowBtn.bottomAnchor, constant: 10),
                privacyPolicyBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
    }
}


// MARK: - Extension View

extension MainScreen.View: MainScreenView {
    
}
