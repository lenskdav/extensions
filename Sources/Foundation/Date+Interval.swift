//
//  Date+Interval.swift
//  Extensions
//
//  Created by David Lenský on 08.01.2021.
//  Copyright © 2021 David Lenský. All rights reserved.
//

import Foundation

//===----------------------------------------------------------------------===//
// MARK: - Date Interval
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// MARK: - Enum
//===----------------------------------------------------------------------===//

public enum Interval {
    case nanoseconds(Int? = nil)
    case microseconds(Int? = nil)
    case milliseconds(Int? = nil)
    case seconds(Int? = nil)
    case minutes(Int? = nil)
    case hours(Int? = nil)
    case days(Int? = nil)
    case months(Int? = nil)
    case years(Int? = nil)

    case never
}

//===----------------------------------------------------------------------===//
// MARK: - Value
//===----------------------------------------------------------------------===//

public extension Interval {

    var value: Int {
        switch self {
        case .nanoseconds(let val),
             .microseconds(let val),
             .milliseconds(let val),
             .seconds(let val),
             .minutes(let val),
             .hours(let val),
             .days(let val),
             .months(let val),
             .years(let val): return val ?? 0
        case .never: return 0
        }
    }

}

//===----------------------------------------------------------------------===//
// MARK: - Conversions
//===----------------------------------------------------------------------===//

public extension Interval {

    func to(_ interval: Interval) -> Interval {
        switch (self, interval) {
        case (.nanoseconds, .nanoseconds): return .nanoseconds(value)
        case (.nanoseconds, .microseconds): return .microseconds(value / 1000)
        case (.nanoseconds, .milliseconds): return .milliseconds((value / 1000) / 1000)
        case (.nanoseconds, .seconds): return .seconds(((value / 1000) / 1000) / 1000)
        case (.nanoseconds, .minutes): return .minutes((((value / 1000) / 1000) / 1000) / 60)
        case (.nanoseconds, .hours): return .hours(((((value / 1000) / 1000) / 1000) / 60) / 60)
        case (.nanoseconds, .days): return .days((((((value / 1000) / 1000) / 1000) / 60) / 60) / 24)

        case (.microseconds, .nanoseconds): return .nanoseconds(value * 1000)
        case (.milliseconds, .nanoseconds): return .nanoseconds(value * 1000 * 1000)
        case (.seconds, .nanoseconds): return .nanoseconds(value * 1000 * 1000 * 1000)
        case (.minutes, .nanoseconds): return .nanoseconds(value * 60 * 1000 * 1000 * 1000)
        case (.hours, .nanoseconds): return .nanoseconds(value * 60 * 60 * 1000 * 1000 * 1000)
        case (.days, .nanoseconds): return .nanoseconds(value * 24 * 60 * 60 * 1000 * 1000 * 1000)

        case (.nanoseconds, .months): return .never
        case (.months, .nanoseconds): return .never

        case (.nanoseconds, .years): return .never
        case (.years, .nanoseconds): return .never

        case (_, .never): return .never
        case (.never, _): return .never

        default: return to(.nanoseconds()).to(interval)
        }
    }

}

//===----------------------------------------------------------------------===//
// MARK: - Operations
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// MARK: - To -> DateComponents
//===----------------------------------------------------------------------===//

public extension Interval {

    var dateComponents: DateComponents {
        switch self {
        case .nanoseconds(let num): return DateComponents(nanosecond: num ?? 0)
        case .microseconds(let num): return DateComponents(nanosecond: (num ?? 0) * 1000)
        case .milliseconds(let num): return DateComponents(nanosecond: (num ?? 0) * 1000000)
        case .seconds(let num): return DateComponents(second: num ?? 0)
        case .minutes(let num): return DateComponents(minute: num ?? 0)
        case .hours(let num): return DateComponents(hour: num ?? 0)
        case .days(let num): return DateComponents(day: num ?? 0)
        case .months(let num): return DateComponents(month: num ?? 0)
        case .years(let num): return DateComponents(year: num ?? 0)
        case .never: return DateComponents()
        }
    }

    var negativeDateComponents: DateComponents {
        switch self {
        case .nanoseconds(let num): return DateComponents(nanosecond: -(num ?? 0))
        case .microseconds(let num): return DateComponents(nanosecond: -(num ?? 0) * 1000)
        case .milliseconds(let num): return DateComponents(nanosecond: -(num ?? 0) * 1000000)
        case .seconds(let num): return DateComponents(second: -(num ?? 0))
        case .minutes(let num): return DateComponents(minute: -(num ?? 0))
        case .hours(let num): return DateComponents(hour: -(num ?? 0))
        case .days(let num): return DateComponents(day: -(num ?? 0))
        case .months(let num): return DateComponents(month: -(num ?? 0))
        case .years(let num): return DateComponents(year: -(num ?? 0))
        case .never: return DateComponents()
        }
    }

}

//===----------------------------------------------------------------------===//
// MARK: - From <- DateComponents
//===----------------------------------------------------------------------===//

public extension DateComponents {

    /**
     When resolving anything shorter than month, it does not take into account months and years, because they are irregular. The parameter "interval" does not care about it's associated value.
     */
    func `in`(_ interval: Interval) -> Interval {
        switch interval {
        case .nanoseconds, .microseconds, .milliseconds, .seconds, .minutes, .hours, .days:
            let nanosecondsInterval = Interval.days(day).to(.nanoseconds()).value
                + Interval.hours(hour).to(.nanoseconds()).value
                + Interval.minutes(minute).to(.nanoseconds()).value
                + Interval.seconds(second).to(.nanoseconds()).value
                + Interval.nanoseconds(nanosecond).to(.nanoseconds()).value

            return Interval.nanoseconds(nanosecondsInterval).to(interval)

        case .months, .years:
            let monthInterval = Interval.years(year).to(.nanoseconds()).value
                + Interval.months(month).to(.nanoseconds()).value

            return Interval.months(monthInterval).to(interval)

        case .never: return .never
        }
    }

}
