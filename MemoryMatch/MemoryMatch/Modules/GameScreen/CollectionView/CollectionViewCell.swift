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
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    // MARK: - Private functions
    
    // MARK: - Methods
    
    private func setup() {
        buildHierarchy()
        configureSubviews()
        setupLayoutSubviews()
    }
    
    private func buildHierarchy() {
        addView(backView)
    }
    
    private func configureSubviews() {
        
    }
    
    private func setupLayoutSubviews() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: topAnchor),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
