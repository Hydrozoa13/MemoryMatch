//
//  CollectionView.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 7.08.24.
//

import UIKit

final class CollectionView: UICollectionView {
    
    var spacing: CGFloat = 16
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = spacing * 1.3
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
