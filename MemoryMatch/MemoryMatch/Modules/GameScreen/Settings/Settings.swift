//
//  Settings.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 8.08.24.
//

import UIKit

final class Settings: UIView {
    
    // MARK: - Properties
    
    private var resumeActionTapped: (() -> Void)?
    private var dismissActionTapped: (() -> Void)?
    
    // MARK: - Subviews
    
    private let overlay = UIView(frame: UIScreen.main.bounds)
    private let background = UIImageView(image: .settingsBackground)
    
    private let resumeBtn = Button(title: "RESUME")
    private let mainMenuBtn = Button(title: "MAIN MENU")
    
    private let soundBtn = Button(style: .small, normalImage: .sound, selectedImage: .mutedSound)
    private let vibrationBtn = Button(style: .small, normalImage: .vibration, selectedImage: .noVibration)
    
    // MARK: - Initializers
    
    init(resumeAction: (() -> Void)? = nil, dismissAction: (() -> Void)? = nil) {
        self.resumeActionTapped = resumeAction
        self.dismissActionTapped = dismissAction
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
            widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.94),
            heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9)
        ])
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            self.layer.opacity = 1
            self.overlay.layer.opacity = 0.7
        }
    }
    
    // MARK: - Private Functions
    
    private func removeSettingsView(isDismission: Bool = false) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            self.layer.opacity = 0
            self.overlay.layer.opacity = 0
        } completion: { [weak self] _ in
            guard let self else { return }
            self.removeFromSuperview()
            self.overlay.removeFromSuperview()
            self.resumeActionTapped?()
            
            if isDismission {
                self.dismissActionTapped?()
            }
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
        background.addView(resumeBtn)
        background.addView(mainMenuBtn)
        background.addView(soundBtn)
        background.addView(vibrationBtn)
    }
    
    private func configureSubviews() {
        background.isUserInteractionEnabled = true
        layer.opacity = 0
        layer.cornerRadius = 12
        overlay.layer.opacity = 0
        overlay.backgroundColor = .black
        clipsToBounds = true
        
        soundBtn.isSelected = !SoundManager.isEnabled
        vibrationBtn.isSelected = !Vibration.isEnabled
    }
    
    private func setupActions() {
        resumeBtn.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            resumeBtn.buttonPressed {
                self.removeSettingsView()
            }
        }), for: .touchUpInside)
        
        mainMenuBtn.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            mainMenuBtn.buttonPressed {
                self.removeSettingsView(isDismission: true)
            }
        }), for: .touchUpInside)
        
        soundBtn.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            soundBtn.buttonPressed {
                SoundManager.isEnabled.toggle()
                self.soundBtn.isSelected.toggle()
            }
        }), for: .touchUpInside)
        
        vibrationBtn.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            vibrationBtn.buttonPressed {
                Vibration.isEnabled.toggle()
                self.vibrationBtn.isSelected.toggle()
            }
        }), for: .touchUpInside)
    }
    
    private func setupLayoutSubviews() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            resumeBtn.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.48),
            resumeBtn.heightAnchor.constraint(equalTo: resumeBtn.widthAnchor, multiplier: 0.24),
            resumeBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            resumeBtn.topAnchor.constraint(equalTo: topAnchor, constant: 55),
            
            mainMenuBtn.widthAnchor.constraint(equalTo: resumeBtn.widthAnchor),
            mainMenuBtn.heightAnchor.constraint(equalTo: resumeBtn.heightAnchor),
            mainMenuBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainMenuBtn.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 10),
            
            soundBtn.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.12),
            soundBtn.heightAnchor.constraint(equalTo: soundBtn.widthAnchor),
            soundBtn.leadingAnchor.constraint(equalTo: mainMenuBtn.leadingAnchor),
            soundBtn.topAnchor.constraint(equalTo: mainMenuBtn.bottomAnchor, constant: 32),
            
            vibrationBtn.widthAnchor.constraint(equalTo: soundBtn.widthAnchor),
            vibrationBtn.heightAnchor.constraint(equalTo: vibrationBtn.widthAnchor),
            vibrationBtn.trailingAnchor.constraint(equalTo: mainMenuBtn.trailingAnchor),
            vibrationBtn.topAnchor.constraint(equalTo: soundBtn.topAnchor)
        ])
    }
}
