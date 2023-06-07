//
//  DateExtension.swift
//  InstaSwift
//
//  Created by Bruno Rangel on 07/06/23.
//

import SwiftUI

extension Date {
    func elapsedTime() -> String {
        let secondsPerMinute: TimeInterval = 60
        let secondsPerHour: TimeInterval = 3600
        let secondsPerDay: TimeInterval = 86400
        let secondsPerWeek: TimeInterval = 604800

        let currentDate = Date()
        let differenceInSeconds = currentDate.timeIntervalSince(self).magnitude

        switch differenceInSeconds {
        case 0 ..< secondsPerMinute:
            let timeDifference = differenceInSeconds
            return "\(Int(timeDifference)) second\(timeDifference > 1 ? "s" : "") ago"
        case secondsPerMinute ..< secondsPerHour:
            let timeDifference = (differenceInSeconds / secondsPerMinute).rounded(.down)
            return "\(Int(timeDifference)) minute\(timeDifference > 1 ? "s" : "") ago"
        case secondsPerHour ..< secondsPerDay:
            let timeDifference = (differenceInSeconds / secondsPerHour).rounded(.down)
            return "\(Int(timeDifference)) hour\(timeDifference > 1 ? "s" : "") ago"
        case secondsPerDay ..< secondsPerWeek:
            let timeDifference = (differenceInSeconds / secondsPerDay).rounded(.down)
            return "\(Int(timeDifference)) day\(timeDifference > 1 ? "s" : "") ago"
        default:
            let timeDifference = (differenceInSeconds / secondsPerWeek).rounded(.down)
            return "\(Int(timeDifference)) week\(timeDifference > 1 ? "s" : "") ago"
        }
    }
}
