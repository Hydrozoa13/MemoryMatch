//
//  GameScreen+Presenter.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import Foundation

extension GameScreen {
    class Presenter {
        
        // MARK: - Properties
        
        weak var view: GameScreenView?
        
        var firstIndexPath: IndexPath?
        var movesCounter = 0
        var pairsCount = 0
        
        var timer = Timer()
        var timerCount = 0
        var timerCounting = true
        var time = ""
        
        // MARK: - Initializers
        
        init() {
            print(#function, self)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                         selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
        
        deinit { print(#function, self) }
        
        // MARK: - Methods
        
        private func formatTimeToString(seconds: Int) -> String {
            let (min, sec) = (((seconds % 3600) / 60), ((seconds % 3600) % 60))
            var timeString = ""
            timeString += String(format: "%02d", min)
            timeString += ":"
            timeString += String(format: "%02d", sec)
            return timeString
        }
        
        @objc func timerCounter() -> Void {
            timerCount += 1
            let timeString = formatTimeToString(seconds: timerCount)
            time = timeString
            view?.updateTimeLabel()
        }
        
        // MARK: - Actions
        
        func toggleTimer() {
            if timerCounting {
                timer.invalidate()
            } else {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                             selector: #selector(timerCounter), userInfo: nil, repeats: true)
            }
            
            timerCounting.toggle()
        }
    }
}
