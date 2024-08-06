//
//  UILabelExt.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import UIKit

extension UILabel {
    
    func configure(textAlignment: NSTextAlignment = .center,
                   text: String,
                   textColor: UIColor = .white,
                   font: UIFont,
                   numberOfLines: Int = 0,
                   lineHeight: CGFloat
    ) {
        
        self.text = text
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
        
        let mutableAttributedString = NSMutableAttributedString(attributedString: text.setLineHeight(lineHeight))
        
        self.attributedText = mutableAttributedString
        self.textAlignment = textAlignment
    }
}
