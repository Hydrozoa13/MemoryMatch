//
//  CollectionViewCell.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 7.08.24.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        get { "CollectionViewCell" }
    }
    
    // MARK: - Subviews
    
    private let backView = UIImageView(image: .cellView)
    private let slotView = UIImageView()
    private let slotCurtain = UIImageView(image: .slotCurtain)
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func setupCell(with image: UIImage) {
        slotView.image = image
    }
    
    func changeCurtainState(isOpening: Bool = true) {
        UIView.animate(withDuration: 0.5) {
            self.slotCurtain.layer.opacity = isOpening ? 0 : 1
        }
    }
    
    // MARK: - Private functions
    
    // MARK: - Methods
    
    private func setup() {
        buildHierarchy()
        configureSubviews()
        setupLayoutSubviews()
    }
    
    private func buildHierarchy() {
        addView(backView)
        backView.addView(slotView)
        backView.addView(slotCurtain)
    }
    
    private func configureSubviews() {
        
    }
    
    private func setupLayoutSubviews() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: topAnchor),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            slotView.widthAnchor.constraint(equalTo: backView.widthAnchor, multiplier: 0.75),
            slotView.heightAnchor.constraint(equalTo: slotView.widthAnchor, multiplier: 0.95),
            slotView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            slotView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            
            slotCurtain.widthAnchor.constraint(equalTo: slotView.widthAnchor),
            slotCurtain.heightAnchor.constraint(equalTo: slotView.heightAnchor),
            slotCurtain.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            slotCurtain.centerYAnchor.constraint(equalTo: backView.centerYAnchor)
        ])
    }
}
