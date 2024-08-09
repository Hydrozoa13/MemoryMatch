//
//  LoadingScreenView.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import UIKit

struct LoadingScreen { }

protocol LoadingScreenView: ViewDelegate {
    func animateFire()
}
