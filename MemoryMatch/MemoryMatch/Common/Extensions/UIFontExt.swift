//
//  UIFontExt.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import UIKit

extension UIFont {
    
    static func inter(of size: CGFloat) -> UIFont {
        return UIFont(name: "WixMadeforDisplay-Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
    }
    
    static func interRegular(of size: CGFloat) -> UIFont {
        return UIFont(name: "interRegular", size: size) ?? .systemFont(ofSize: size, weight: .regular)
    }
}
