//
//  ParkBenchTimer.swift
//  Navigation
//
//  Created by Stepas Vilkelis on 23.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ParkBenchTimer {

    let startTime:Date
    var endTime:Date?

    init() {
        startTime = Date()
    }

    func stop() -> TimeInterval {
        endTime = Date()

        return duration!
    }

    var duration:TimeInterval? {
        if let endTime = endTime {
            return DateInterval.init(start: startTime, end: endTime).duration
        } else {
            return nil
        }
    }
}
