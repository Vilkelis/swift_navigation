//
//  BackgroundTest.swift
//  Navigation
//
//  Created by Stepas Vilkelis on 23.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class BackgroundTest {
    
    var previous = NSDecimalNumber.one
    var current = NSDecimalNumber.one
    var position: UInt = 1
    var updateTimer: Timer?
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    var timer: ParkBenchTimer?
    
    func run() {
        resetCalculation()
        updateTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self,
                                           selector: #selector(calculateNextNumber), userInfo: nil, repeats: true)
        registerBackgroundTask()
        timer = ParkBenchTimer()
        print("Фоновая задача начала работу...")
    }
    
    func resetCalculation() {
      previous = .one
      current = .one
      position = 1
    }
    
    func registerBackgroundTask() {
      backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
        self?.endBackgroundTask()
      }
      assert(backgroundTask != .invalid)
    }
    
    func endBackgroundTask() {
      updateTimer?.invalidate()
      updateTimer = nil
      print("Фоновая задача остановлена.")
      let seconds = timer!.stop()
      print("Выполнялось все \(seconds) секунд.")
      UIApplication.shared.endBackgroundTask(backgroundTask)
      backgroundTask = .invalid
    }
    
    @objc func calculateNextNumber() {
      let result = current.adding(previous)
      
      let bigNumber = NSDecimalNumber(mantissa: 1, exponent: 40, isNegative: false)
      if result.compare(bigNumber) == .orderedAscending {
        previous = current
        current = result
        position += 1
      } else {
        // This is just too much.... Start over.
        resetCalculation()
      }
        
      print("Позиция \(position) = \(current)")
    }
}
