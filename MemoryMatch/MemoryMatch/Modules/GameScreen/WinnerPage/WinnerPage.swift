//
//  WinnerPage.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 8.08.24.
//

import UIKit

final class WinnerPage: UIView {
    
    // MARK: - Properties
    
    private var count: Int
    private var time: String
    
    private var resumeActionTapped: (() -> Void)?
    private var dismissActionTapped: (() -> Void)?
    
    // MARK: - Subviews
    
    private let overlay = UIView(frame: UIScreen.main.bounds)
    private let background = UIImageView(image: .winnerBackground)
    private let winnerFrame = UIImageView(image: .winnerFrame)
    private let youWin = UIImageView(image: .youWin)
    private let movesLabel = UILabel()
    private let timeLabel = UILabel()
    private let newGameBtn = UIButton()
    private let menuBtn = UIButton()
    
    // MARK: - Initializers
    
    init(count: Int, time: String, resumeAction: (() -> Void)? = nil, dismissAction: (() -> Void)? = nil) {
        self.resumeActionTapped = resumeAction
        self.dismissActionTapped = dismissAction
        self.count = count
        self.time = time
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func show(in view: UIView) {
        view.addView(overlay)
        view.addView(self)

        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
            widthAnchor.constraint(equalTo: view.widthAnchor),
            heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            self.layer.opacity = 1
            self.overlay.layer.opacity = 0.7
        }
    }
    
    // MARK: - Private Functions
    
    private func removeWinnerView(isDismission: Bool = false) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            self.layer.opacity = 0
            self.overlay.layer.opacity = 0
        } completion: { [weak self] _ in
            guard let self else { return }
            self.removeFromSuperview()
            self.overlay.removeFromSuperview()
            isDismission ? self.dismissActionTapped?() : self.resumeActionTapped?()
        }
    }
    
    // MARK: - Methods
    
    private func setup() {
        buildHierarchy()
        configureSubviews()
        setupLayoutSubviews()
        setupActions()
    }
    
    private func buildHierarchy() {
        addView(background)
        background.addView(winnerFrame)
        winnerFrame.addView(movesLabel)
        winnerFrame.addView(timeLabel)
        background.addView(youWin)
        background.addView(newGameBtn)
        background.addView(menuBtn)
    }
    
    private func configureSubviews() {
        background.isUserInteractionEnabled = true
        layer.opacity = 0
        layer.cornerRadius = 12
        overlay.layer.opacity = 0
        overlay.backgroundColor = .black
        clipsToBounds = true
        
        movesLabel.configure(text: "MOVIES: " + String(count), font: .inter(of: 20), lineHeight: 24)
        timeLabel.configure(text: "TIME: " + time, font: .inter(of: 20), lineHeight: 24)
        
        newGameBtn.setImage(.newGameBtn, for: .normal)
        menuBtn.setImage(.menuBtn, for: .normal)
    }
    
    private func setupActions() {
        newGameBtn.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            removeWinnerView()
        }), for: .touchUpInside)
        
        menuBtn.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            removeWinnerView(isDismission: true)
        }), for: .touchUpInside)
    }
    
    private func setupLayoutSubviews() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            winnerFrame.widthAnchor.constraint(equalTo: background.widthAnchor, multiplier: 0.8),
            winnerFrame.heightAnchor.constraint(equalTo: winnerFrame.widthAnchor, multiplier: 0.53),
            winnerFrame.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 80),
            winnerFrame.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            movesLabel.centerXAnchor.constraint(equalTo: winnerFrame.centerXAnchor),
            movesLabel.topAnchor.constraint(equalTo: winnerFrame.centerYAnchor),
            
            timeLabel.centerXAnchor.constraint(equalTo: winnerFrame.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: movesLabel.bottomAnchor),
            
            youWin.widthAnchor.constraint(equalTo: background.widthAnchor, multiplier: 0.92),
            youWin.heightAnchor.constraint(equalTo: youWin.widthAnchor, multiplier: 1),
            youWin.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -70),
            youWin.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            newGameBtn.widthAnchor.constraint(equalTo: background.widthAnchor, multiplier: 0.112),
            newGameBtn.heightAnchor.constraint(equalTo: newGameBtn.widthAnchor),
            newGameBtn.topAnchor.constraint(equalTo: winnerFrame.bottomAnchor, constant: 16),
            newGameBtn.trailingAnchor.constraint(equalTo: winnerFrame.centerXAnchor, constant: -8),
            
            menuBtn.widthAnchor.constraint(equalTo: newGameBtn.widthAnchor),
            menuBtn.heightAnchor.constraint(equalTo: menuBtn.widthAnchor),
            menuBtn.topAnchor.constraint(equalTo: winnerFrame.bottomAnchor, constant: 16),
            menuBtn.leadingAnchor.constraint(equalTo: winnerFrame.centerXAnchor, constant: 8)
        ])
    }
}
