//
//  NotificationsScreen+View.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import UIKit

extension NotificationsScreen {
    class View: UIViewController {
        
        // MARK: - Properties
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        
        // MARK: - Subviews
        
        private let background = UIImageView(image: .background)
        private let money = UIImageView(image: .money)
        private let gradient = UIImageView(image: .notificationsGradient)
        private let menuIcon = UIImageView(image: .menuIcon)
        
        private let titleText = UILabel()
        private let subtitleText = UILabel()
        
        private let allowNotificationsBtn = UIButton()
        private let skipBtn = UIButton()
        
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
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            setup()
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
            background.addView(money)
            background.addView(gradient)
            background.addView(menuIcon)
            background.addView(titleText)
            background.addView(subtitleText)
            background.addView(allowNotificationsBtn)
            background.addView(skipBtn)
        }
        
        private func configureSubviews() {
            background.isUserInteractionEnabled = true
            
            titleText.configure(text: "Allow notifications about bonuses and promos".uppercased(),
                                font: .inter(of: 22), lineHeight: 35)
            
            subtitleText.configure(text: "Stay tuned with best offers from\nour casino",
                                   textColor: .lightGray,
                                   font: .interRegular(of: 18), lineHeight: 24)
            
            allowNotificationsBtn.backgroundColor = #colorLiteral(red: 0.9447571635, green: 0.8693771958, blue: 0.2781870365, alpha: 1)
            allowNotificationsBtn.layer.cornerRadius = 8
            let attributedString2 = NSMutableAttributedString(string: "Yes, I Want Bonuses!")
            attributedString2.addAttributes([.font: UIFont.interRegular(of: 18), .foregroundColor: UIColor.black],
                                           range: NSRange(location: 0, length: attributedString2.length))
            allowNotificationsBtn.setAttributedTitle(attributedString2, for: .normal)
            
            let attributedString = NSMutableAttributedString(string: "Skip")
            attributedString.addAttributes([.font: UIFont.interRegular(of: 18), .foregroundColor: UIColor.lightGray],
                                           range: NSRange(location: 0, length: attributedString.length))
            skipBtn.setAttributedTitle(attributedString, for: .normal)
        }
        
        private func setupActions() {
            allowNotificationsBtn.addAction(UIAction(handler: { [weak self] _ in
                guard let self else { return }
                presenter.savePermissionForNotifications()
                presenter.navigateToLoadingScreen()
            }), for: .touchUpInside)
            
            skipBtn.addAction(UIAction(handler: { [weak self] _ in
                guard let self else { return }
                presenter.navigateToLoadingScreen()
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
                
                gradient.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.58),
                gradient.leadingAnchor.constraint(equalTo: background.leadingAnchor),
                gradient.trailingAnchor.constraint(equalTo: background.trailingAnchor),
                gradient.bottomAnchor.constraint(equalTo: background.bottomAnchor),
                
                menuIcon.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.88),
                menuIcon.heightAnchor.constraint(equalTo: menuIcon.widthAnchor, multiplier: 0.9),
                menuIcon.bottomAnchor.constraint(equalTo: background.centerYAnchor, constant: -30),
                menuIcon.centerXAnchor.constraint(equalTo: background.centerXAnchor),
                
                titleText.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 16),
                titleText.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -16),
                titleText.bottomAnchor.constraint(equalTo: subtitleText.topAnchor, constant: -16),
                
                subtitleText.leadingAnchor.constraint(equalTo: titleText.leadingAnchor),
                subtitleText.trailingAnchor.constraint(equalTo: titleText.trailingAnchor),
                subtitleText.bottomAnchor.constraint(equalTo: allowNotificationsBtn.topAnchor, constant: -32),
                
                allowNotificationsBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.065),
                allowNotificationsBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.86),
                allowNotificationsBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                allowNotificationsBtn.bottomAnchor.constraint(equalTo: skipBtn.topAnchor, constant: -24),
                
                skipBtn.centerXAnchor.constraint(equalTo: background.centerXAnchor),
                skipBtn.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -56)
            ])
        }
    }
}


// MARK: - Extension View

extension NotificationsScreen.View: NotificationsScreenView {
    
}
