//
//  Button.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 8.08.24.
//

import UIKit

final class Button: UIButton {
    
    // MARK: - Properties
    
    private var title: String
    
    // MARK: - Subviews
    
    private let background = UIImageView(image: .buttonBackground)
    private let textLabel = UILabel()
    
    // MARK: - Initializers
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func animatePressing(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self else { return }
            self.layer.opacity = 0.5
            self.layer.opacity = 1
        } completion: { _ in completion() }
    }
    
    private func setup() {
        configureSubviews()
        buildHierarchy()
        setupLayoutSubviews()
    }
    
    private func buildHierarchy() {
        addView(background)
        background.addView(textLabel)
    }
    
    private func configureSubviews() {
        textLabel.configure(text: title, font: .inter(of: 20), lineHeight: 22)
    }
    
    private func setupLayoutSubviews() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

