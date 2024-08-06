//
//  StringExt.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import UIKit

extension String {
    
    func setLineHeight(_ height: CGFloat) -> NSAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = height
        paragraphStyle.maximumLineHeight = height
        
        let attributedString = NSAttributedString(
            string: self,
            attributes: [.paragraphStyle: paragraphStyle]
        )
        
        return attributedString
    }
}
