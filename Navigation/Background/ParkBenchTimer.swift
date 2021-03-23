//
//  ParkBenchTimer.swift
//  Navigation
//
//  Created by Stepas Vilkelis on 23.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import CoreFoundation

class ParkBenchTimer {

    let startTime:CFAbsoluteTime
    var endTime:CFAbsoluteTime?

    init() {
        startTime = CFAbsoluteTimeGetCurrent()
    }

    func stop() -> CFAbsoluteTime {
        endTime = CFAbsoluteTimeGetCurrent()

        return duration!
    }

    var duration:CFAbsoluteTime? {
        if let endTime = endTime {
            return endTime - startTime
        } else {
            return nil
        }
    }
}
