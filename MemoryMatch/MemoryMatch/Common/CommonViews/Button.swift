//
//  Button.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 8.08.24.
//

import UIKit

enum ButtonStyle {
    case big
    case small
}

final class Button: UIButton {
    
    // MARK: - Properties
    
    private lazy var title = ""
    
    // MARK: - Subviews
    
    private lazy var background = UIImageView(image: .buttonBackground)
    private lazy var textLabel = UILabel()
    
    // MARK: - Initializers
    
    init(style: ButtonStyle = .big, title: String = "",
         normalImage: UIImage? = nil, selectedImage: UIImage? = nil) {
        
        super.init(frame: .zero)
        self.title = title
        
        style == .big ? setupBigButton() : setupSmallButton(normalImage: normalImage ?? nil,
                                                            selectedImage: selectedImage ?? nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func buttonPressed(completion: @escaping () -> Void) {
        Vibration.vibrate(type: .light)
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self else { return }
            self.layer.opacity = 0.5
            self.layer.opacity = 1
        } completion: { _ in completion() }
    }
    
    private func setupBigButton() {
        addView(background)
        background.addView(textLabel)
        
        textLabel.configure(text: title, font: .inter(of: 20), lineHeight: 22)
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupSmallButton(normalImage: UIImage?, selectedImage: UIImage?) {
        setImage(normalImage, for: .normal)
        setImage(selectedImage, for: .selected)
    }
}
